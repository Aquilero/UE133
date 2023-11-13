resource "aws_sns_topic" "prometheus_alerts" {
  name = "prometheus_alerts"
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.prometheus_alerts.arn
  protocol  = "email"
  endpoint  = "XXXXXX.XXXXXXX@XXXX.XXXXXXX.de"
}

data "aws_iam_policy_document" "sns_policy" {
  policy_id = "sns_prometheus_alerts_policy"

  statement {
    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission",
    ]

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      aws_sns_topic.prometheus_alerts.arn,
    ]

    sid = "__default_statement_ID"
  }
}
