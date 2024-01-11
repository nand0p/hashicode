data "archive_file" "lambda_hashicode" {
  type = "zip"

  source_dir  = "${path.module}/${var.product}"
  output_path = "${path.module}/${var.product}.zip"
}

resource "aws_s3_object" "lambda_hashicode" {
  bucket = aws_s3_bucket.lambda_bucket.id

  key    = "${var.product}.zip"
  source = data.archive_file.lambda_hashicode.output_path

  etag = filemd5(data.archive_file.lambda_hashicode.output_path)
}


resource "aws_lambda_function" "hashicode" {
  function_name = var.product

  s3_bucket = aws_s3_bucket.lambda_bucket.id
  s3_key    = aws_s3_object.lambda_hashicode.key

  runtime = "nodejs18.x"
  handler = "${var.product}.handler"

  source_code_hash = data.archive_file.lambda_hashicode.output_base64sha256

  role = aws_iam_role.lambda_exec.arn
}


resource "aws_cloudwatch_log_group" "hashicode" {
  name = "/aws/lambda/${aws_lambda_function.hashicode.function_name}"

  retention_in_days = 30
}


resource "aws_iam_role" "lambda_exec" {
  name = "serverless_lambda"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}


output "function_name" {
  description = "hashicode lambda"

  value = aws_lambda_function.hashicode.function_name
}
