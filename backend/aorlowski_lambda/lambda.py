import json, boto3

east_1_session = boto3.Session(region_name = 'us-east-1')
table = east_1_session.resource('dynamodb').Table('aorlowski-visitors')
def lambda_handler(event, context):
    response_body_count = 0
    if (event['httpMethod'] == 'POST'):
        # Increment the visitor counter atomically
        update = table.update_item(
            Key={
                'statistic': 'view-count'
            },
            UpdateExpression="ADD Quantity :inc",
            ExpressionAttributeValues={
                ':inc': 1
            },
            ReturnValues="UPDATED_NEW"
        )
        
        response_body_count = update['Attributes']['Quantity']
    else:
        response = table.get_item(Key={'statistic': 'view-count'})
        item = response['Item']
        count = item['Quantity']
        response_body_count = count

    #TODO implement
    result = {
        "isBase64Encoded": False,
        "statusCode": "200",
        "headers": {},
        "body": response_body_count
    }
    return result