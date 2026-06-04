import json
import boto3

lambda_client = boto3.client("lambda")

def get_tag(tags, tag_name):
    return tags.get(tag_name, "Tag does not exist")

def lambda_handler(event, context):

    print("Received Event:")
    print(json.dumps(event, indent=2))

    lambda_arn = (
        event.get("detail", {}).get("lambdaArn")
        or event.get("lambdaArn")
    )

    print(f"Lambda ARN: {lambda_arn}")

    if not lambda_arn:
        print("lambdaArn not found in event")

        return {
            "statusCode": 400,
            "message": "lambdaArn not provided"
        }

    try:

        response = lambda_client.list_tags(
            Resource=lambda_arn
        )

        print("Raw Tag Response:")
        print(json.dumps(response, indent=2))

        tags = response.get("Tags", {})

        result = {
            "LambdaArn": lambda_arn,
            "ApplicationName": get_tag(tags, "ApplicationName"),
            "TechnicalOwner": get_tag(tags, "TechnicalOwner"),
            "BusinessOwner": get_tag(tags, "BusinessOwner")
        }

        print("Final Result:")
        print(json.dumps(result, indent=2))

        return {
            "statusCode": 200,
            "body": json.dumps(result)
        }

    except Exception as e:

        print(f"Error reading tags: {str(e)}")

        return {
            "statusCode": 500,
            "message": str(e)
        }
