resource "aws_wafv2_web_acl" "demowafacl" {
  name  = var.name
  scope = "REGIONAL"

  default_action {
    allow {}
  }

  tags = {
    Name = "${var.name}"
  }
  rule {
    name     = "rule-1"
    priority = 1

    override_action {
      count {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"


      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "waf-rule-alb"
      sampled_requests_enabled   = true
    }
  }
  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = var.metric_name
    sampled_requests_enabled   = true
  }

}
resource "aws_wafv2_web_acl_association" "demoaclalbassocation" {
  resource_arn = var.alb-arn-var
  web_acl_arn   = aws_wafv2_web_acl.demowafacl.arn
}

