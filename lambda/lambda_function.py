import json

def lambda_handler(event, context):

    print("===== AWS HEALTH EVENT RECEIVED =====")
    print(json.dumps(event, indent=2))

    return {
        "statusCode": 200,
        "body": "Event logged successfully"
    }
