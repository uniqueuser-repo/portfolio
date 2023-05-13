# START DYNAMODB FOR VIEWER COUNT
# START DYNAMODB FOR VIEWER COUNT
resource "aws_dynamodb_table" "dynamodb_statistics_table" {
    name = "aorlowski-visitors"
    provider = aws.east-1

    billing_mode = "PAY_PER_REQUEST"
    hash_key = "statistic"

    read_capacity = 0
    write_capacity = 0
    stream_enabled = false
    table_class = "STANDARD_INFREQUENT_ACCESS"
    
    attribute {
      name = "statistic"
      type = "S"
    }

    point_in_time_recovery {
      enabled = true
    }

    timeouts {}

    lifecycle {
      ignore_changes = [
        write_capacity,
        read_capacity
      ]
    }
}

# INSERT viewer_count STATISTIC
resource "aws_dynamodb_table_item" "viewer_count_statistic" {
    provider = aws.east-1
    table_name = aws_dynamodb_table.dynamodb_statistics_table.name
    hash_key = aws_dynamodb_table.dynamodb_statistics_table.hash_key

    item = <<ITEM
    {
        "statistic": {"S": "view-count"},
        "Quantity": {"N": "0"}
    }
    ITEM

    lifecycle {
        ignore_changes = [
          item
        ]
    }
}
# END DYNAMODB FOR VIEWER COUNT
# END DYNAMODB FOR VIEWER COUNT

# START DYNAMODB FOR BLOG
# START DYNAMODB FOR BLOG
resource "aws_dynamodb_table" "blog_table" {
  name = local.blog_table_name
  provider = aws.east-1

  billing_mode = "PAY_PER_REQUEST"
  hash_key = "id"

  read_capacity = 0
  write_capacity = 0
  stream_enabled = false
  table_class = "STANDARD_INFREQUENT_ACCESS"

  attribute {
    name = "id"
    type = "S"
  }

  point_in_time_recovery {
    enabled = true
  }

  timeouts {}

  lifecycle {
    ignore_changes = [
      write_capacity,
      read_capacity
    ]
  }
}

# INSERT blog data
resource "null_resource" "insert_blog_data" {
  provisioner "local-exec" {
    command = "python ./util/insert_blog_data.py"
  }
}

# END DYNAMODB FOR BLOG
# END DYNAMODB FOR BLOG