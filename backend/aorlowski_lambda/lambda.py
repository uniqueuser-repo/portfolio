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

    # Whitelisted origins to access this endpoint are:
    whitelisted_origins = {
        'http://localhost:3000': 'http://localhost:3000',
        'https://www.aorlowski.com': 'https://www.aorlowski.com',
        'https://aorlowski.com': 'https://aorlowski.com'
    }
    
    print('event is ' + str(event))
    request_origin = 'NoOriginFoundInHeaders'
    if 'headers' in event and event['headers'] is not None and 'origin' in event['headers'] and event['headers']['origin'] is not None:
        request_origin = event['headers']['origin']

    
    origin_to_allow = 'http://localhost:3000'
    if request_origin in whitelisted_origins:
        origin_to_allow = request_origin

    result = {
        "isBase64Encoded": False,
        "statusCode": "200",
        "headers": {
            'content-type': 'application/json',
            'Access-Control-Allow-Origin': origin_to_allow
        },
        "body": response_body_count
    }
    return result