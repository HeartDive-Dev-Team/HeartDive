extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var HPTexture = get_node("GUI/HP");
onready var staminaTexture = get_node("GUI/STAMINA")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	HPTexture.value = gvar.G_playerHealth;
	staminaTexture.value = gvar.G_playerStamina;

func turnON():
	visible = true;
	get_node("GUI/HP").visible = true;
	get_node("GUI/STAMINA").visible = true;

func turnOFF():
	visible = false;
	get_node("GUI/HP").visible = false;
	get_node("GUI/STAMINA").visible = false;
