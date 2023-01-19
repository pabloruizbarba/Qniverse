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


@csrf_exempt
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