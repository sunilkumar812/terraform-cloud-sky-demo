import json
import boto3

lambda_client = boto3.client("lambda")

REQUIRED_TAGS = [
    "ApplicationName",
    "TechnicalOwner",
    "BusinessOwner"
]


def get_tag(tags, tag_name):
    return tags.get(tag_name, "Tag does not exist")


def lambda_handler(event, context):

    print("Received Event:")
    print(json.dumps(event, indent=2))

    lambda_arn = event.get("lambdaArn")

    if not lambda_arn:
        return {
            "statusCode": 400,
            "message": "lambdaArn not provided"
        }

    try:

        response = lambda_client.list_tags(
            Resource=lambda_arn
        )

        tags = response.get("Tags", {})

        result = {
            "LambdaArn": lambda_arn,
            "ApplicationName": get_tag(tags, "ApplicationName"),
            "TechnicalOwner": get_tag(tags, "TechnicalOwner"),
            "BusinessOwner": get_tag(tags, "BusinessOwner")
        }

        print(json.dumps(result, indent=2))

        return {
            "statusCode": 200,
            "body": json.dumps(result)
        }

    except Exception as e:

        print(f"Error: {str(e)}")

        return {
            "statusCode": 500,
            "message": str(e)
        }
