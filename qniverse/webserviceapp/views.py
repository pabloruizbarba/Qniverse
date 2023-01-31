from django.http import HttpResponse, JsonResponse
import jwt
from webserviceapp.models import User, League, Question, Ratequestion
from django.views.decorators.csrf import csrf_exempt
import json
import bcrypt
import random

@csrf_exempt
def add_question(request):
    """Add a new question to database"""
    # Get token from headers
    token = request.headers.get('Auth-Token')

    try: 
        data = json.loads(request.body)
    except json.decoder.JSONDecodeError:
        return HttpResponse('Invalid JSON', status=400)
    # Try to get token from database
    try:
        tokenDB = User.objects.get(tokensession=token)
    except: 
        return HttpResponse('Bad request - Missed or incorrect params', status=400)
    #Check if token exists or both are equal   
    if not token or token != tokenDB.tokensession:
        # Invalid token, return 401 error
        return HttpResponse('Unauthorized - User not logged', status=401)
    else:
        # Check if repost is of type POST
        if request.method == 'POST':  
            question = Question() 
            question.id_user =  User.objects.get(id=data['id_user'])
            question.description = data['question']
            question.answer1 = data['answer1']
            question.answer2 = data['answer2']
            question.answer3 = data['answer3']
            question.answer4 = data['answer4']
            question.correctanswer = data['correct-answer']
            question.image = data['correct-image']
            question.upvotes = 0
            question.downvotes = 0
            question.activatedingame = False
            # Check if there is an image
            if 'image' in data:
                question.image = data['image']
            # Save changes
            question.save()
            return HttpResponse("Question created", status=201)
        # If the request is not of type POST...
        else:
            return HttpResponse('Bad request - Missed or incorrect params', status=400)



@csrf_exempt
def update_user(request):
    """Update username"""
    #CHECK IF METHOD IS POST
    if request.method != 'POST':
        HttpResponse("Method not allowed",status=405)

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

    for i in range(1,5):
        # Save up to 4 info questions in a array
        if i == len(questions): # check if there aren't more questions in DB
            break
        q = random.choice(questions)
        index = int(q.id)
      
        while index in rates or str(index) in str(prev) or q in response_questions:
            q = random.choice(questions)
            index = int(q.id)

        response_questions.append(q)
        i=i+1
    return JsonResponse(response_questions,status=200) # send questions in utf-8
   