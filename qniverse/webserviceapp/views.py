from django.http import HttpResponse, JsonResponse
import jwt
from webserviceapp.models import User, League
from django.views.decorators.csrf import csrf_exempt
import json
import bcrypt

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
        # If the passwords match...(encrypted)
        print("----------------------------")

        if user.check_password(data['password']):
        # A session token is generated, saved to the database.
            token = jwt.encode({'user_id': user.id}, 'secret', algorithm='HS256')
            user.tokensession = token
            user.save()
        # And it is sent in the response along with the rating and the username.
            return JsonResponse({'session_token': user.tokensession, 'elo': user.elo, 'username': user.username}, status=201)
        # If the passwords don't match...
        return JsonResponse({'error': 'Unauthorized'}, status=401)
    # If the request is not of type POST...
    return JsonResponse({'error': 'Method not allowed'}, status=405)


@csrf_exempt
def register_user(request):
    """Register a new user in database"""

    if request.method != "POST":
        return None

    try:
        json_request = json.loads(request.body)

        new_user = User()

        new_user.username = json_request['username']
        new_user.email = json_request['email']
        new_user.pass_field = new_user.encrypt_password(json_request['password'])

        new_user.id_league = League.objects.get(id=1)
        new_user.elo = 0
        new_user.creationdate = "17/01/2023"
        new_user.save()

        return JsonResponse({"created_user": "ok"})
    except Exception as e:
        print(e)
