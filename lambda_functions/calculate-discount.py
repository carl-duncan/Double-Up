import json
import urllib3
import boto3
from decimal import Decimal


def lambda_handler(event, context):
    value = calulateTotalDiscount(event["id"])
    if (value["redeemed"]!=True):
        value["redeemed"]=True
        dynamodb = boto3.resource('dynamodb')

        setRedeemed(event["id"],dynamodb)
        updateUserPoints(event["user"],value["price"],dynamodb)
    else:
        value["redeemed"]="Already Redeemed/Invalid QR"
    return {
        'statusCode': 200,
        'body':value
    }

def updateUserPoints(id,amount,dynamodb):
    table = dynamodb.Table('CustomerTable')
    response = table.update_item(
        Key={
            'id': id,
        },
        UpdateExpression="set balance = balance + :val",
        ExpressionAttributeValues={
            ':val': Decimal(str(amount))
        },
        ReturnValues="UPDATED_NEW"
    )

def setRedeemed(transaction_id,dynamodb):
    table = dynamodb.Table('TransactionTable')

    response = table.update_item(
        Key={
            'id': transaction_id,
        },
        UpdateExpression="set redeemed = :val",
        ExpressionAttributeValues={
            ':val': True
        },
        ReturnValues="UPDATED_NEW"
    )

def calulateTotalDiscount(id):
    url = ""
    payload = "{\"query\":\"query MyQuery {\\n  getTransaction(id: \\\""+id+"\\\") {\\n    id\\n  redeemed\\n  products {\\n      loss\\n      min\\n      max\\n      price\\n      sales\\n    }\\n  }\\n}\\n\",\"operationName\":\"MyQuery\"}"
    http = urllib3.PoolManager()
    response = http.request("POST", url, body=payload,headers={'Content-Type': 'application/json',"x-api-key": ""})
    resp_json=json.loads(response.data.decode('utf8'))
    total = 0
    price_total=0
    products = resp_json["data"]["getTransaction"]["products"]
    length = len(products)
    for x in range(length):
        value = discount(products[x]["loss"],products[x]["sales"],products[x]["min"],products[x]["max"])
        price_total+=products[x]["price"]
        # print(value)
        total+=value
    return {"price": price_total * (total/length),"redeemed":resp_json["data"]["getTransaction"]["redeemed"]}

def discount(UnsoldCount, SalesCount, MinDiscount, MaxDiscount):
    return max(min(UnsoldCount/SalesCount, MaxDiscount), MinDiscount)
