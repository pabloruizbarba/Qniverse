from django.http import HttpResponse, JsonResponse
import jwt
from webserviceapp.models import User, League, Question
from django.views.decorators.csrf import csrf_exempt
import json
import bcrypt

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



@csrf_exempt
def get_user(request, name):
    """Get specific user info"""

    if request.method != 'GET':
        return HttpResponse("Method Not Allowed", status=405)

    # CHECK IF USER IS LOG IN
    try:
        User.objects.get(tokensession=request.headers.get('Auth-Token'))
    except:
        return HttpResponse("Unauthorized - User not logged", status=401)


    # CHECK IF USER EXIST IN DATABASE
    try:
        user = User.objects.get(username=name)
    except:
        return HttpResponse("User not found", status=404)

    return JsonResponse({"username": user.username, "elo": user.elo, "eloPlanet": user.id_league.name, "editable": False}, status=200)





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

    return HttpResponse("Email sent successfully", status=200)
