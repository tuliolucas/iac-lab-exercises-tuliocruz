resource "aws_security_group" "lb_sg" {
    name        = "${var.prefix}-lb-sg"
    description = "Security group for the application load balancer"
    vpc_id      = module.vpc.vpc_id

    ingress {
        description = "Allow HTTP from anywhere"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "Allow app port from the load balancer itself"
        from_port   = 8000
        to_port     = 8000
        protocol    = "tcp"
        self        = true
    }

    egress {
        description = "Allow all outbound traffic"
        from_port   = 0
        to_port     = 0
        protocol    = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = format("%s-lb-sg", var.prefix)
    }
}

resource "aws_lb" "lb" {
    name               = "${var.prefix}-lb"
    load_balancer_type = "application"
    internal           = false
    security_groups    = [aws_security_group.lb_sg.id]
    subnets            = module.vpc.private_subnets

    tags = {
        Name = format("%s-lb-sg", var.prefix)
    }
}

resource "aws_lb_target_group" "tg" {
    name        = "${var.prefix}-tg"
    port        = 8000
    protocol    = "HTTP"
    vpc_id      = module.vpc.vpc_id
    target_type = "ip"

    health_check {
        path                = "/"
        protocol            = "HTTP"
        matcher             = "200-399"
        interval            = 30
        timeout             = 5
        healthy_threshold   = 2
        unhealthy_threshold = 2
    }

    tags = {
        Name = format("%s-lb-tg", var.prefix)
    }
}

resource "aws_lb_listener" "listener" {
    load_balancer_arn = aws_lb.lb.arn
    port              = 80
    protocol          = "HTTP"

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.tg.arn
    }

    tags = {
        Name = format("%s-lb-listener", var.prefix)
    }
}