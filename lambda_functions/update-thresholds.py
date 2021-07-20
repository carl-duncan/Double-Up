import json
import boto3
from decimal import Decimal

def lambda_handler(event, context):
    response = updateThresholds()
    return {
        'statusCode': 200,
        'body': response
    }

def updateThresholds():
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table('ProductTable')
    response = table.scan()
    data = response['Items']
    print(data)
    for item in data:
        value = discount(item["loss"],item["sales"],item["min"],item["max"])
        response = table.update_item(
            Key={
                'id': item["id"],
            },
            UpdateExpression="set threshold=:r",
            ExpressionAttributeValues={
                ':r': Decimal(value),
            },
            ReturnValues="UPDATED_NEW"
        )
    return True

def discount(UnsoldCount, SalesCount, MinDiscount, MaxDiscount):
    return max(min(UnsoldCount/SalesCount, MaxDiscount), MinDiscount)
