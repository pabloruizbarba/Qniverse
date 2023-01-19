from django.http import HttpResponse, JsonResponse
import jwt
from webserviceapp.models import User, League, Question
from django.views.decorators.csrf import csrf_exempt
import json
import bcrypt


@csrf_exempt
def login_user(request):
    """A registered user can login into the app"""

    if request.method != 'POST':
        return None

    try:
        data = json.loads(request.body)

        if 'email' in data:
            user = User.objects.get(email=data['email'])
        elif 'username' in data:
            user = User.objects.get(username=data['username'])
        else:
            return JsonResponse({'error': 'Missing parameters'}, status=400)

        if user.check_password(data['password']):
            token = jwt.encode({'user_id': user.id}, 'secret', algorithm='HS256')
            user.tokenSession = token
            user.save()
            return JsonResponse(
                {
                    'session_token': user.tokensession,
                    'elo': user.elo,
                    'username': user.username
                },
                status=201
            )

        return JsonResponse({'error': 'Incorrect password'}, status=401)
    except Exception as e:
        print(e)


@csrf_exempt
def register_user(request):
    """Register a new user in database"""

    if request.method != "POST":
        return None

    try:
        data = json.loads(request.body)

        new_user = User()
        new_user.username = data['username']
        new_user.email = data['email']
        new_user.pass_field = new_user.encrypt_password(data['password'])
        new_user.id_league = League.objects.get(id=1)
        new_user.elo = 0
        new_user.creationdate = "17/01/2023"
        new_user.save()

        return JsonResponse({"created_user": "ok"}, status=201)
    except Exception as e:
        print(e)


@csrf_exempt
def add_question(request):
    """Add a new question to database"""
    
    token = request.headers.get('Auth-Token')
    try: 
        data = json.loads(request.body)
    except json.decoder.JSONDecodeError:
        return JsonResponse({'error': 'Invalid JSON'}, status=400)
    try:
        tokenDB = User.objects.get(tokensession=token)
    except Exception as e: 
        return JsonResponse({'error': 'Bad request - Missed or incorrect params'}, status=400)
    if not token or token != tokenDB.tokensession:
        # Invalid token, return 401 error
        return JsonResponse({'error': 'Unauthorized - User not logged'}, status=401)
    else:
        if request.method == 'POST':  
            question = Question() 
            question.id_user =  User.objects.get(id=data['id_user'])
            question.description = data['description']
            question.answer1 = data['answer1']
            question.answer2 = data['answer2']
            question.answer3 = data['answer3']
            question.answer4 = data['answer4']
            question.correctanswer = data['correctAnswer']
            if 'image' in data:
                question.image = data['image']
            question.save()
            return JsonResponse({"Question created":"201"})
        # If the request is not of type POST...
        else:
            return JsonResponse({'error': 'Bad request - Missed or incorrect params'}, status=400)

