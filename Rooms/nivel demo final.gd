extends "res://Objects/CutsceneSystem.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var player = get_node("obj_Player");
onready var text = get_node("CutsceneSystem-TextHandler/CanvasLayer/textBox");
export var portraits = [];
export var voices = [];


# Called when the node enters the scene tree for the first time.
func _ready():
	
	changeVoice(voices[0]);
	changePortrait(portraits[0]);
	changeName("Text");
	changeAnimation("default");


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match scenePhase:
		0: #Inicio
			player.reading = true;
			_delay(100);
		1:
			showMessage("Bueno, esto es el final de la Demo de hoy");
			_delay(0);
		2:
			showMessage("Espero que les haya gustado!");
			_delay(0);
		3:
			showMessage("Nos vemos en la próxima Demo!");
			_delay(0);
		4:
			player.reading = false;
