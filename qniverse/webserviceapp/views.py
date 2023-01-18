from django.shortcuts import render
from django.http import JsonResponse
import jwt
from webserviceapp.models import User
from django.views.decorators.csrf import csrf_exempt
import json

# Create your views here.

@csrf_exempt
def login(request):
    if request.method == 'POST':     
        # Extract the data from the request body as a JSON object.
        data = json.loads(request.body) 
        #  The JSON object is checked to see if it contains an "email" or "username" field and the database is searched.
        if 'email' in data:
            user = User.objects.get(email=data['email'])
        elif 'username' in data:
            user = User.objects.get(username=data['username'])
        # If any of the fields are not found, an error is returned with a 400 status code.
        else:
            return JsonResponse({'error': 'Missing parameters'}, status=400)
        #If a user is found, the password sent in the JSON object is checked to see if it matches the password stored in the database.
        # If the passwords match...
        if user.pass_field == data['password']:
        # A session token is generated, saved to the database.
            token = jwt.encode({'user_id': user.id}, 'secret', algorithm='HS256')
            user.tokensession = token
            user.save()
        # And it is sent in the response along with the rating and the username.
            return JsonResponse({'session_token': user.tokensession, 'elo': user.elo, 'username': user.username}, status=201)
        # If the passwords don't match...
        else:
            return JsonResponse({'error': 'Unauthorized'}, status=401)
    # If the request is not of type POST...
    else:
        return JsonResponse({'error': 'Method not allowed'}, status=405)