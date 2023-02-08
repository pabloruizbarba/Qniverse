
import json
import asyncio
import random
from datetime import datetime
from asgiref.sync import sync_to_async
from channels.generic.websocket import AsyncWebsocketConsumer
from django.core.exceptions import ObjectDoesNotExist
from webserviceapp.models import Game, Lobby, User

class CreateOrSearchGame(AsyncWebsocketConsumer):
    
    async def connect(self):
        await self.accept()

    async def disconnect(self, close):
        pass

    @sync_to_async
    def get_lobbies(self):
        return list(Lobby.objects.all())

    @sync_to_async
    def get_lobby(self,lobby_getted_id):
        return Lobby.objects.get(id=lobby_getted_id)
    @sync_to_async
    def save_in_db(self,model):
        return model.save()

    @sync_to_async
    def get_user_by_tokensession(self,gtokensession):
        return User.objects.get(tokensession=gtokensession)

    @sync_to_async
    def get_user_by_id(self,gid):
        return User.objects.get(id=gid)

    async def receive(self, text_data):
        print("Create or search for a Lobby")
        text_data_json = json.loads(text_data)
        message = text_data_json.get("status", None)
        answer = text_data_json.get("answer", None)
        tokensession = text_data_json.get("Auth-Token", None)
        lobby_getted = False
        

        try:
            user = await self.get_user_by_tokensession(tokensession)
        #Gestionamos la excepción para ver qué hacemos si el token no es válido, evitando que crashee el servidor
        except ObjectDoesNotExist:
            await self.send(text_data=json.dumps({"reply": "Invalid Auth-Token"}))
            return


        try: # search for a lobby waiting
            lobbies = await self.get_lobbies()
            for lobby_in_db in lobbies:
                if lobby_in_db.visibility == 1:
                    lobby_in_db.visibility = 0
                    lobby_in_db.id_user_2 = user.id
                    await self.save_in_db(lobby_in_db)
                    lobby_getted_id = lobby_in_db.id
                    lobby_getted = True

                    rival = await self.get_user_by_id(lobby_in_db.id_user_1)

                    dt = datetime.now()
                    gs = datetime.timestamp(dt)
                    gs += 10

                    await self.send(text_data=json.dumps({"reply": "Lobby getted", "rival": rival.username, "game_start": gs}))
                    break
            
            # if lobby no exists create one
            if not lobby_getted:
                lobby = Lobby()
                lobby.creationdate = datetime.now().strftime("%Y/%m/%d - %H:%M:%S")
                lobby.privatecode = random.randint(100000, 999999) # 6 digits number
                lobby.visibility = 1
                lobby.id_user_1 = user.id
                
                await self.save_in_db(lobby)

                lobby_getted_id = lobby.id
            
                await self.send(text_data=json.dumps({"reply": "Lobby created"}))


                # wait for another player
                while True:
                    await asyncio.sleep(2)
                    lobby = await self.get_lobby(lobby_getted_id)
                    print("Wating for a another player in lobby: "+str(lobby.id))
                    if lobby.visibility == 0:
                        rival = await self.get_user_by_id(lobby_in_db.id_user_2)

                        dt = datetime.now()
                        gs = datetime.timestamp(dt)
                        gs += 10

                        await self.send(text_data=json.dumps({"reply": "Lobby getted", "rival": rival.username, "game_start": gs}))
                        break



        # -> Lobby.DoesNotExist
        except:
            # if lobby no exists create one
            if not lobby_getted:
                lobby = Lobby()
                lobby.creationdate = datetime.now().strftime("%Y/%m/%d - %H:%M:%S")
                lobby.privatecode = random.randint(100000, 999999) # 6 digits number
                lobby.visibility = 1
                lobby.id_user_1 = user.id
                
                await self.save_in_db(lobby)

                lobby_getted_id = lobby.id
            
                await self.send(text_data=json.dumps({"reply": "Lobby created"}))


                # wait for another player
                while True:
                    await asyncio.sleep(2)
                    lobby = await self.get_lobby(lobby_getted_id)
                    print("Wating for a another player in lobby: "+str(lobby.id))
                    if lobby.visibility == 0:
                        rival = await self.get_user_by_id(lobby_in_db.id_user_2)

                        dt = datetime.now()
                        gs = datetime.timestamp(dt)
                        gs += 10

                        await self.send(text_data=json.dumps({"reply": "Lobby getted", "rival": rival.username, "game_start": gs}))
                        break