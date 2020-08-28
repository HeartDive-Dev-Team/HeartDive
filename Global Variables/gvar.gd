extends Node

#################################
#    Configuration Variables    #------------------------------
#################################

var G_fullScreen = false;
var G_musicVolume = 0;
var G_SFXVolume = 0;

###########################
#    General Variables    #------------------------------
###########################

# TODO lo que sea global, lleva el prefijo "G_"
var G_playerHealth = 5;
var G_MAXHealth = 5;
var G_playerWalljump = true;
var G_playerDash = true;
var G_playerPunch = true;

###########################
#    In-Game Variables    #------------------------------
###########################
#Todo lo que se use en el gameplay pero no es muy persistente
var G_targetSpawn = -1; #The target spawnpoint, used between every single room transition
# -1 = checkpoint
# 0 or more = spawnpoint ID
var G_checkpointRoom = ""; #The room where the checkpoint is


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#############################
#       HEALTH MANAGER      #-----------------------------
#############################
func HUD_ON():
	HealthManager.turnON();
func HUD_OFF():
	HealthManager.turnOFF();
