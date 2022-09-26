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
      enabled = false
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