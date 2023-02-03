import json, time

from channels.generic.websocket import WebsocketConsumer

class PublicLobbyConsumer(WebsocketConsumer):
    
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

        