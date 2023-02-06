import json, time
from webserviceapp.models import Game, Lobby, User
from channels.generic.websocket import AsyncWebsocketConsumer
from datetime import datetime
import random
import time
import asyncio
from channels.db import database_sync_to_async

class PublicLobbyConsumer(AsyncWebsocketConsumer):
    
    def connect(self):
        self.accept()

    def disconnect(self, close_code):
        pass
	
    def receive(self, text_data):
        print("Received message...")
        text_data_json = json.loads(text_data)
        message = text_data_json.get("customMessage", None)
        answer = text_data_json.get("answer", None)
        if message == "Hello":
            self.send(text_data=json.dumps({"customReply": "Hello to you, good sir"}))
        else:
            if answer is not None:
                if answer == "a":
                    self.send(text_data=json.dumps({"customReply": "Correct answer!!"}))
                elif answer == "b":
                    self.send(text_data=json.dumps({"customReply": "Oh... wrong answer"}))
                # Ahora efectuamos una acción cada 2 segundos.
                # Esto podría ser 'polling' de la base de datos
                # (usando sentencias ORM como GameAnswer.objects.get(...))
                # para averiguar, por ejemplo, si el otro jugador ya ha respondido
                attempts = 0
                while attempts < 5:
                    time.sleep(2)
                    self.send(text_data=json.dumps({"customReply": "El servidor ha esperado ficticiamente " + str(attempts) + " ve(ces). Podria haber consultado la base de datos para informarte de que el otro jugador ya ha contestado o de que se ha encontrado una partida"}))
                    attempts += 1
            else:
                print("Nothing to do...")

                # Nota:
                # Una alternativa a polling de base de datos sería usar channel layers
                # https://channels.readthedocs.io/en/latest/tutorial/part_2.html#enable-a-channel-layer


@database_sync_to_async
def get_lobbies():
    return Lobby.objects.all()

@database_sync_to_async
def get_lobby(lobby_id):
    return Lobby.objects.get(id=lobby_id)

@database_sync_to_async
def create_lobby():
    return Lobby()

@database_sync_to_async
def get_user(tokensession):
    return User.objects.get(tokensession=tokensession)

class CreateOrSearchGame(AsyncWebsocketConsumer):
    
    async def connect(self):
        await self.accept()

    async def disconnect(self, close_code):
        pass
    
    async def receive(self, text_data):
        print("Create or search for a Lobby")
        text_data_json = json.loads(text_data)
        message = text_data_json.get("status", None)
        answer = text_data_json.get("answer", None)
        tokensession = text_data_json.get("Auth-Token", None)

        lobbies = await get_lobbies()
        lobby_getted = False
        lobby = await create_lobby()



        # si existe lo coge
        for lobby_in_db in lobbies:
            if lobby_in_db.visibility == 1:
                await self.send(text_data=json.dumps({"reply": "Lobby getted", "lobby_id": lobby_in_db.id}))
                lobby_in_db.visibility = 0
                lobby_in_db.save()
                lobby_getted_id = lobby_in_db.id
                lobby_getted = True
                break
        


        # si no existe lo crea
        if lobby_getted == False:
            date = datetime.now().strftime("%Y/%m/%d - %H:%M:%S")
            lobby.creationdate = date
            lobby.privatecode = random.randint(100000, 999999) # 6 digits number
            lobby.visibility = 1
            lobby.id_user = await get_user(tokensession)
            lobby.save()
            lobby_getted_id = lobby.id
            await self.send(text_data=json.dumps({"reply": "Lobby created", "lobby_id": lobby.id}))
        
            # espera hasta que encuentre otro jugador
            while True:
                await asyncio.sleep(5)
                lobby = await get_lobby(lobby_getted_id)
                print("Wating for a another player in lobby: "+str(lobby.id))
                if lobby.visibility == 0:
                    await self.send(text_data=json.dumps({"reply": "User in", "lobby_id": lobby.id}))
                    break