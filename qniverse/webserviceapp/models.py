# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models
import bcrypt

class Game(models.Model):
    id_user_1 = models.IntegerField(primary_key=True)
    id_user_2 = models.IntegerField()
    id_lobby = models.ForeignKey('Lobby', models.DO_NOTHING, db_column='id_lobby')
    id_question = models.ForeignKey('Question', models.DO_NOTHING, db_column='id_question')
    time = models.CharField(max_length=100, blank=True, null=True)
    success = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'Game'
        unique_together = (('id_user_1', 'id_user_2', 'id_lobby'),)


class League(models.Model):
    name = models.CharField(max_length=25, blank=True, null=True)
    minelo = models.IntegerField(db_column='minElo', blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'League'


class Lobby(models.Model):
    creationdate = models.CharField(db_column='creationDate', max_length=100, blank=True, null=True)  # Field name made lowercase.
    privatecode = models.TextField(db_column='privateCode', blank=True, null=True)  # Field name made lowercase.
    visibility = models.IntegerField(blank=True, null=True)
    id_user_1 = models.IntegerField(blank=True, null=True)
    id_user_2 = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'Lobby'


class Question(models.Model):
    id_user = models.ForeignKey('User', models.DO_NOTHING, db_column='id_user')
    description = models.CharField(max_length=200, blank=True, null=True)
    answer1 = models.CharField(max_length=50, blank=True, null=True)
    answer2 = models.CharField(max_length=50, blank=True, null=True)
    answer3 = models.CharField(max_length=50, blank=True, null=True)
    answer4 = models.CharField(max_length=50, blank=True, null=True)
    correctanswer = models.IntegerField(db_column='correctAnswer', blank=True, null=True)  # Field name made lowercase.
    image = models.CharField(max_length=200, blank=True, null=True)
    upvotes = models.IntegerField(db_column='upVotes', blank=True, null=True)  # Field name made lowercase.
    downvotes = models.IntegerField(db_column='downVotes', blank=True, null=True)  # Field name made lowercase.
    activatedingame = models.IntegerField(db_column='activatedInGame', blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Question'


class User(models.Model):
    id_league = models.ForeignKey(League, models.DO_NOTHING, db_column='id_league', blank=True, null=True)
    username = models.CharField(max_length=20, blank=True, null=True)
    email = models.CharField(max_length=100, blank=True, null=True)
    pass_field = models.CharField(db_column='pass', max_length=100, blank=True, null=True)  # Field renamed because it was a Python reserved word.
    tokenpass = models.CharField(db_column='tokenPass', max_length=100, blank=True, null=True)  # Field name made lowercase.
    tokensession = models.CharField(db_column='tokenSession', max_length=100, blank=True, null=True)  # Field name made lowercase.
    elo = models.IntegerField(blank=True, null=True)
    creationdate = models.CharField(db_column='creationDate', max_length=100, blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'User'
        
    def encrypt_password(self, raw_password):
        return bcrypt.hashpw(raw_password.encode('utf-8'), bcrypt.gensalt()).decode('utf-8')

    def check_password(self, raw_password):
        return bcrypt.checkpw(raw_password.encode('utf-8'), self.pass_field.encode('utf-8'))


class Ratequestion(models.Model):
    id_user = models.OneToOneField(User, models.DO_NOTHING, db_column='id_user', primary_key=True)
    id_question = models.ForeignKey(Question, models.DO_NOTHING, db_column='id_question')
    rating = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'rateQuestion'
        unique_together = (('id_user', 'id_question'),)
