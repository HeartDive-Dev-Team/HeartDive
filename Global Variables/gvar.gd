extends Node

###########################
#    General Variables    #------------------------------
###########################

# TODO lo que sea global, lleva el prefijo "G_"
var G_playerHealth = 5;
var G_MAXHealth = 5;
var G_playerWalljump = true;
var G_playerDash = true;
var G_playerPunch = true;

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
