resource "aws_ssm_document" "serv_status_chk_doc" {
  name          = var.serv_status_chk_doc_name
  document_type = "Command"

  content = <<EOF
{
  "schemaVersion": "2.2",
  "description": "Command Document JSON Template",
  "parameters": {
    "Message": {
      "type": "String",
      "description": "check Apache service if it is running or not.",
      "default": "Apache service status"
    }
  },
  "mainSteps": [
    {
      "action": "aws:runShellScript",
      "name": "apacheServiceStatuschk",
      "inputs": {
        "runCommand": [
          "#!/bin/bash",
          "instance_id=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)",
          "aws_region=$(curl -s 'http://169.254.169.254/latest/dynamic/instance-identity/document' | python -c \"import sys, json; print json.load(sys.stdin)['region']\")",
          "aws_account_id=$(curl -s 'http://169.254.169.254/latest/dynamic/instance-identity/document' | python -c \"import sys, json; print json.load(sys.stdin)['accountId']\")",
          "apache_status=$(systemctl is-active httpd)",
          "if [ \"$apache_status\" = \"active\" ]; then",
          "    echo 'apache service is running on instance: '$instance_id",
          "    exit 0",
          "else",
          "    echo 'Command failed! Apache service is not running on instance: '$instance_id",
          "    message={\"Command failed! Apache service is not running on instance \":$instance_id,\"with Account ID \":$aws_account_id,\"in AWS Region \":$aws_region}",
          "    aws sns --region \"$aws_region\" publish --topic-arn arn:aws:sns:$aws_region:$aws_account_id:serv-status-chk-topic --message \"$message\"",
          "    exit 1",
          "fi"
        ]
      }
    }
  ]
}
EOF
}
