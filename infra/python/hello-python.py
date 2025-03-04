def lambda_handler(event, context):
   message = '{} !'.format(event['key1'])
   return {
       'message' : message
   }

   