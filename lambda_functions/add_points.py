import json
import boto3
from decimal import Decimal

def lambda_handler(event, context):
    dynamodb = boto3.resource('dynamodb')

    return {
        'statusCode': 200,
        'body': updateUserPoints(event["id"],event["amount"],dynamodb)
    }


def updateUserPoints(id,amount,dynamodb):
    table = dynamodb.Table('CustomerTable')
    response = table.update_item(
        Key={
            'id': id,
        },
        UpdateExpression="set balance = balance + :val",
        ExpressionAttributeValues={
            ':val': Decimal(str(amount)),
        },
        ReturnValues="UPDATED_NEW"
    )
    return response