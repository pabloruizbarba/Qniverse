from django.http import HttpResponse, JsonResponse
import jwt
from webserviceapp.models import User, League, Question, Ratequestion
from django.views.decorators.csrf import csrf_exempt
from django.core.mail import send_mail
import json
import bcrypt
import random
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
            users = User.objects.filter(username__istartswith=request.GET.get('username'))

            for user in users:
                usersA.append(user.username)

            return JsonResponse({"users": usersA}, status=200)
        except:
            return HttpResponse("Bad Request - Forget or incorrect params", status=400)


@csrf_exempt
def update_user(request):
    """Update username"""
    #CHECK IF METHOD IS POST
    if request.method != 'POST':
        return HttpResponse("Method not allowed",status=405)

    data = json.loads(request.body)
    user = User()


    # CHECK IF REQUEST IS PROPERLY FORMULATED
    if not "username" in data:
        return HttpResponse('Bad request - Missed or incorrect params', status=400)


    # CHECK IF USER IS LOGGED IN
    try:
        user = User.objects.get(tokensession=request.headers.get('Auth-Token'))
    except:
        return HttpResponse('Unauthorized - User not logged', status=401)


    # CHECK IF USER ALREADY EXISTS
    try:
        User.objects.get(username=data['username'])
        return HttpResponse('Username already in use', status=409)

    except:
        user.username = data['username']
        user.save()
        return HttpResponse("Username updated successfully",status=200)


@csrf_exempt
def password_recovery(request):
    """Forgot password, send an email with recovery code generated"""

    if request.method != 'PUT':
        return HttpResponse("Method Not Allowed", status=405)

    data = json.loads(request.body)
    user = User()

    if not "email" in data:
        return HttpResponse("Bad Request - Forget or incorrect params", status=400)

    try:
        user = User.objects.get(email=data['email'])
    except:
        return HttpResponse("Email not found", status=404)

    # Generate a code that is not in db
    code = 0

    while True:
        code = random.randint(100000, 999999) # 6 digits number
        try:
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
    https://qniverse.es/restore-password/{code}
    '''
    from_email = 'qniverseemail@gmail.com'
    recipient_list = [data["email"]]
    send_mail(subject, message, from_email, recipient_list)

    return HttpResponse("Email sent successfully", status=200)


@csrf_exempt
def restore_password(request):
    """Change old password with a new one"""

    if request.method != 'PUT':
        return HttpResponse("Method Not Allowed", status=405)

    data = json.loads(request.body)
    user = User()

    if not ("code" and "new-pass") in data:
        return HttpResponse("Bad Request - Forget or incorrect params", status=400)

    # Check if code is the same in db
    try:
        user = User.objects.get(tokenpass=data["code"])
    except:
        return HttpResponse("Bad Request - Forget or incorrect params", status=400)

    # Update the new password
    user.pass_field = user.encrypt_password(data["new-pass"])
    user.save()

    return HttpResponse("Password updated succesfully", status=200)

@csrf_exempt
def get_user(request, name):
    """Get specific user info"""

    if request.method != 'GET':
        return HttpResponse("Method Not Allowed", status=405)

    # CHECK IF USER IS LOG IN
    try:
        user_logged = User.objects.get(tokensession=request.headers.get('Auth-Token'))
    except:
        return HttpResponse("Unauthorized - User not logged", status=401)


    # CHECK IF USER EXIST IN DATABASE
    try:
        user = User.objects.get(username=name)
    except:
        return HttpResponse("User not found", status=404)

    editable = False

    if user_logged == user:
        editable = True

    return JsonResponse({"username": user.username, "elo": user.elo, "eloPlanet": user.id_league.name, "editable": editable}, status=200)


@csrf_exempt
def login_user(request):
    """Create a session"""

    data = json.loads(request.body)
    user = User()

    if request.method != 'POST':
        return HttpResponse("Method Not Allowed", status=405)

    # CHECK IF REQUEST IS PROPERLY FORMULATED
    if not "username" in data or not "password" in data:
        return HttpResponse("Bad Request - Forget or incorrect params", status=400)
    
    # IF REQUEST IS WITH USERNAME
    try:
        User.objects.get(username=data["username"])

        user = User.objects.get(username=data["username"])
        if user.check_password(data['password']):
            user.tokensession = jwt.encode({'user_id': user.id}, 'secret', algorithm='HS256')
            user.save()

            return JsonResponse({"username": user.username, "elo": user.elo, "session_token": user.tokensession}, status=201)
        else:
            return HttpResponse("Incorrect password", status=401)
    except:
        # IF REQUEST IS WITH EMAIL
        try:
            User.objects.get(email=data["username"])

            user = User.objects.get(email=data["username"])
            if user.check_password(data['password']):
                user.tokensession = jwt.encode({'user_id': user.id}, 'secret', algorithm='HS256')
                user.save()

                return JsonResponse({"username": user.username, "elo": user.elo, "session_token": user.tokensession}, status=201)
            else:
                return HttpResponse("Incorrect password", status=401)

        except:
            return HttpResponse("User or email dont exists", status=404)


@csrf_exempt
def add_question(request):
    """Add a new question to database"""
    
    if request.method != 'POST':
        return HttpResponse("Method Not Allowed", status=405)

    # CHECK IF USER IS LOG IN
    try:
        token = User.objects.get(tokensession=request.headers.get('Auth-Token'))
        data = json.loads(request.body)
    except:
        return HttpResponse("Unauthorized - User not logged", status=401)

    try:
        question = Question() 
        question.id_user =  User.objects.get(tokensession=token.tokensession)
        question.description = data['description']
        question.answer1 = data['answer1']
        question.answer2 = data['answer2']
        question.answer3 = data['answer3']
        question.answer4 = data['answer4']
        question.correctanswer = data['correctAnswer']
        question.image = data["image"] if "image" in data else None
        question.save()
        return HttpResponse("Question created", status=201)
    except:
        return HttpResponse('Bad request - Missed or incorrect params', status=400)


@csrf_exempt
def questions_to_validate(request):
    
    """Get 4 questions from database"""

    # CHECK IF USER IS LOGGED IN
    try:
        user=User.objects.get(tokensession=request.headers.get('Auth-Token'))  
    except:
        return HttpResponse("Unauthorized - User not logged", status=401)

    # Check if method is POST
    if request.method != 'POST':
        HttpResponse("Method not allowed",status=405)
    
    # Get rates from current user
    try:
        rates = Ratequestion.objects.filter(id_user=user.id)
    except:
        return HttpResponse("Unauthorized - User not logged", status=401)

    # Get previous questions
    prev = json.loads(request.body).get('previus_questions',[])
 
    questions = Question.objects.all() # get all the questions in DataBase
    response_questions = [] 
    response_q = []
    for i in range(1,5):
        # Save up to 4 info questions in a array
        if i == len(questions): # check if there aren't more questions in DB
            break
        q = random.choice(questions)
        index = int(q.id)
      
        while index in rates or str(index) in str(prev) or q in response_q:
            q = random.choice(questions)
            index = int(q.id)
        
        question = {
            "id": q.id,
            "description": q.description,
            "answer1": q.answer1,
            "answer2": q.answer2,
            "answer3": q.answer3,
            "answer4": q.answer4,
            "correctAnswer": q.correctanswer,
            "image": q.image if q.image else "",
            "upVotes": q.upvotes,
            "downVotes": q.downvotes,
            "activatedInGame": q.activatedingame
        }
        response_q.append(q)
        response_questions.append(question)
        i=i+1
    return JsonResponse(response_questions,json_dumps_params={'ensure_ascii':False}, safe=False,status=200) 


@csrf_exempt
def question_vote(request, question_id):
    """Vote a question"""

    if request.method != 'POST':
        return HttpResponse("Method Not Allowed", status=405)

    data = json.loads(request.body)

    if not "rating" in data or question_id <= 0:
        return HttpResponse("Bad Request - Forget or incorrect params", status=400)

    try:
        user = User.objects.get(tokensession=request.headers.get('Auth-Token'))
    except:
        return HttpResponse("Unauthorized - User not logged", status=401)
        
    try:
        question = Question.objects.get(id=question_id)
    except:
        return HttpResponse("Not found", status=404)

    # Check if user already voted
    if Ratequestion.objects.filter(id_user=user.id, id_question=question_id).exists():
        return HttpResponse("Conflict - User already voted", status=409)

    if data["rating"] == "True":
        Ratequestion.objects.create(id_user=user, id_question=question,rating=True)
    else:
        Ratequestion.objects.create(id_user=user, id_question=question,rating=False)

    upvotes = Ratequestion.objects.filter(id_question=question, rating=True).count()
    downvotes = Ratequestion.objects.filter(id_question=question, rating=False).count()

    question.upvotes = upvotes
    question.downvotes = downvotes

    if upvotes - downvotes >= 5:
        question.activatedingame = True
    else:
        question.activatedingame = False

    question.save()

    return HttpResponse("Ok", status=200)


@csrf_exempt
def recive_questions(request):
    """ Get a number of questions 
    
        Query parameters:
            - total: number of questions getted
    """

    if request.method != 'GET':
        return HttpResponse("Method Not Allowed", status=405)

    try:
        total = request.GET["total"]
        activated_questions = Question.objects.filter(activatedingame=1)
        random_questions = random.sample(list(activated_questions), int(total))
        questions_dict = {"questions": {}}

        questions = []

        for q in random_questions :
            question = {
                "id": q.id,
                "description": q.description,
                "answer1": q.answer1,
                "answer2": q.answer2,
                "answer3": q.answer3,
                "answer4": q.answer4,
                "correctAnswer": q.correctanswer,
                "image": q.image if q.image else "",
            }

            questions.append(question)

        questions_dict["questions"] = questions
    except:
        return HttpResponse("Bad Request - Missing path parameters", status=400)

    return JsonResponse(
        questions_dict,
        json_dumps_params={'ensure_ascii': False},
        safe=False,
        status=200
    ) 