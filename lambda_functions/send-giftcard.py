import json
import urllib3
import boto3
from decimal import Decimal

def lambda_handler(event, context):
    dynamodb = boto3.resource('dynamodb')

    resp_json = sendGiftCard(event)
    updateUserPoints(event["profile"],event["amount"],event["card"],dynamodb)

    return {
        'statusCode': 200,
        'body': resp_json
    }


def sendGiftCard(event):
    url = "https://api.blinksky.com/api/v1/send"
    payload = json.dumps({"gift": {
        "action": "order",
        "apikey": "",
        "sender": "Double Up Rewards",
        "from": "17705551234",
        "dest": event["email"],
        "code": event["card"],
        "amount": event["amount"],
        "postal": "30005",
        "msg": event["message"],
        "reference": "0000000",
        "handle_delivery": False
    }})
    http = urllib3.PoolManager()
    response = http.request("POST", url, body=payload,headers={'Content-Type': 'application/json'})
    return json.loads(response.data.decode('utf8'))

def updateUserPoints(id,amount,card,dynamodb):
    table = dynamodb.Table('CustomerTable')
    response = table.update_item(
        Key={
            'id': id,
        },
        UpdateExpression="set balance = balance - :val , cards = list_append(cards, :c)",
        ExpressionAttributeValues={
            ':val': Decimal(str(amount)),
            ':c': [card],
        },
        ReturnValues="UPDATED_NEW"
    )