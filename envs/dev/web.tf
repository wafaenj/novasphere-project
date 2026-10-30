
# =====================================================
# NOVASPHERE - COMPUTE & AUTO-SCALING
# =====================================================

module "vpc" {
  source      = "git::https://github.com/wafaenj/terraform-aws-module.git?ref=gaby-vcp"
  environment = "dev"
}

# Recherche de l'image Amazon Linux 2023 officielle
data "aws_ami" "compute_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


# 1.Retrouver le Security Group ALB cree par le module reseau

data "aws_security_group" "compute_alb" {
  name       = "novasphere-${var.environment}-alb-sg"
  vpc_id     = module.vpc.vpc_id
  depends_on = [module.vpc]
}

# 2. APPLICATION LOAD BALANCER
resource "aws_lb" "web" {
  name               = "novasphere-${var.environment}-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [data.aws_security_group.compute_alb.id]
  subnets         = module.vpc.public_subnets

  tags = {
    Name        = "novasphere-${var.environment}-alb"
    Environment = var.environment
  }
}

# 3. TARGET GROUP
resource "aws_lb_target_group" "web" {
  name        = "novasphere-${var.environment}-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = module.vpc.vpc_id
  target_type = "instance"

  health_check {
    enabled             = true
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name        = "novasphere-${var.environment}-tg"
    Environment = var.environment
  }
}

# 4. LISTENER HTTP
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.web.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}

# 5. LAUNCH TEMPLATE
resource "aws_launch_template" "web" {
  name_prefix            = "novasphere-${var.environment}-web-"
  image_id               = data.aws_ami.compute_amazon_linux.id
  instance_type          = var.compute_instance_type
  vpc_security_group_ids = [module.vpc.web_security_group_id]

  iam_instance_profile {
    name = var.compute_instance_profile_name
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  user_data = base64encode(templatefile("${path.module}/../../templates/compute-bootstrap.sh.tftpl", {
    environment = var.environment
    region      = var.aws_region
  }))

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name        = "novasphere-${var.environment}-web"
      Environment = var.environment
    }
  }

  tags = {
    Name        = "novasphere-${var.environment}-launch-template"
    Environment = var.environment
  }
}

# 6. AUTO SCALING GROUP
resource "aws_autoscaling_group" "web" {
  name                = "novasphere-${var.environment}-asg"
  min_size            = 2
  max_size            = 4
  desired_capacity    = 2
  vpc_zone_identifier = module.vpc.public_subnets

  target_group_arns         = [aws_lb_target_group.web.arn]
  health_check_type         = "ELB"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "novasphere-${var.environment}-web"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = var.environment
    propagate_at_launch = true
  }

  depends_on = [aws_lb_listener.http]
}
