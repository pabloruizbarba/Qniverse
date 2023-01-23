from django.http import HttpResponse, JsonResponse
import jwt
from webserviceapp.models import User, League, Question
from django.views.decorators.csrf import csrf_exempt
import json
import bcrypt
from datetime import datetime


@csrf_exempt
def create_or_get_users(request):
    """ 

    1- Register a user in database
    2- Get a list of users who start with (request)

    """

    if request.method != 'POST' and request.method != 'GET':
        return HttpResponse("Method Not Allowed", status=405)


    # IF METHOD POST
    # REGISTER A USER
    if request.method == 'POST':

        data = json.loads(request.body)
        user = User()

        # CHECK IF REQUEST IS PROPERLY FORMULATED
        if not "username" in data or not "email" in data or not "password" in data:
            return HttpResponse("Bad Request - Forget or incorrect params", status=400)

        # CHECK IF USERNAME EXISTS
        try:
            User.objects.get(username=data['username'])
            return HttpResponse("Username already in use", status=409)
        except:
            # CHECK IF EMAIL EXISTS
            try:
                User.objects.get(email=data['email'])
                return HttpResponse("Email already in use", status=409)
            except:
                # SAVE USER IN DATABASE
                user.username = data['username']
                user.email = data['email']
                user.pass_field = User.encrypt_password(user, data['password'])

                user.id_league = League.objects.get(id=1)
                user.elo = 0
                user.creationdate = datetime.now().strftime("%Y/%m/%d - %H:%M:%S")
                user.save()

                return HttpResponse("User created", status=201)


    # IF METHOD GET
    # Get a list of users who start with (request)
    if request.method == 'GET':
        
        usersA = []

        # CHECK IF USER IS LOG IN
        try:
            User.objects.get(tokensession=request.headers.get('Auth-Token'))
        except:
            return HttpResponse("Unauthorized - User not logged", status=401)

        print(request.GET.get('username'))
        try:
            users = User.objects.filter(username__startswith=request.GET.get('username'))

            for user in users:
                usersA.append(user.username)

            return JsonResponse({"users": usersA}, status=200)
        except:
            return HttpResponse("Bad Request - Forget or incorrect params", status=400)