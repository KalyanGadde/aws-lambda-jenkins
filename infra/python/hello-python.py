
# Code to read a key and reurn message

def lambda_handler(event, context):
   message = '{} !'.format(event['key1'])
   return {
       'message' : message
   }


# Code to read a key and ping a url provided in key 
# import package.requests

# def lambda_handler(event, context):
#     # Ensure the URL is provided in the event payload
#     url = event.get("url")
    
#     if not url:
#         return {
#             "statusCode": 400,
#             "error": "Missing 'url' parameter in request."
#         }
    
#     try:
#         response = requests.get(url, timeout=5)
#         return {
#             "statusCode": response.status_code,
#             "body": response.text[:500]  # Limit response size
#         }
#     except requests.exceptions.RequestException as e:
#         return {
#             "statusCode": 500,
#             "error": str(e)
#         }

   