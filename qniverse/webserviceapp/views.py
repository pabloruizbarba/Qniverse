from django.http import HttpResponse, JsonResponse
import jwt
from webserviceapp.models import User, League, Question
from django.views.decorators.csrf import csrf_exempt
from django.core.mail import send_mail
import json
import bcrypt
import random


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


def questionsToValidate(request):
    """Get 4 questions from database"""

    response_questions = []
    data = json.loads(request.body)

    token = request.headers.get('Auth-Token') # get the token of user in header request

    questions = Question.objects.all() # get all the questions in DataBase

    # SAVE 4 (or less in case of no more) info questions in a array
    for i in range(int(data["index_question"]), int(data["index_question"]) + 4):

        if i == len(questions): # check if there is no more questions in DB
            break

        question = {
            "description": questions[i].description,
            "answer1": questions[i].answer1,
            "answer2": questions[i].answer2,
            "answer3": questions[i].answer3,
            "answer4": questions[i].answer4,
            "correctAnswer": questions[i].correctanswer,
            "image": questions[i].image if questions[i].image else "",
            "upVotes": questions[i].upvotes,
            "downVotes": questions[i].downvotes,
            "activatedInGame": questions[i].activatedingame
        }
        response_questions.append(question)

    return JsonResponse({"question": response_questions}, safe=False, json_dumps_params={'ensure_ascii': False}) # send questions in utf-8


@csrf_exempt
def password_recovery(request):
    """Forgot password, send an email with recovery code generated"""

    data = json.loads(request.body)
    user = User()

    if not "email" in data:
        return JsonResponse({"status": "400", "description": "Bad Request - Forget or incorrect params"}, status=400)

    try:
        user = User.objects.get(email=data['email'])
    except:
        return JsonResponse({"status": "404", "description": "Email not found"}, status=404)

    # GENERATE A CODE (THATS IS NOT IN THE DATABASE)
    while True:
        try:
            code = str(random.randint(100000, 999999)) # 6 digits number 
            User.objects.get(tokenpass=code)
        except:
            break

    # SAVE TOKEN PASS
    user.tokenpass = code
    user.save()
    
    # SEND EMAIL
    subject = 'Qniverse Password Reset'
    message = f'''
    \nClick in the next link to reset your password:
    \n
    https://qniverse.com/update-password/{code}
    '''
    from_email = 'qniverseemail@gmail.com'
    recipient_list = [data["email"]]
    send_mail(subject, message, from_email, recipient_list)

    return JsonResponse({"status": "200", "description": "Email sent successfully"}, status=200)
