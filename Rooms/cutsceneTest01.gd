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
	player.reading = true;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match scenePhase:
		0: #Inicio
			_delay(10);
		1:
			changePortrait(portraits[0]);
			changeAnimation("OlimacEdgy");
			changeVoice(voices[0]);
			changeName("Olimac")
			showMessage("Hola.");
			_delay(0);
		2:
			changePortrait(portraits[1]);
			changeAnimation("edgy");
			changeVoice(voices[1]);
			changeName("Otro Olimac");
			showMessage("Hacer este sistema de cutscenes me llevó una cantidad inhumana de esfuerzo");
			_delay(0);
		3:
			player.velocity.x = player.WALKSPD;
			_delay(60);
		4:
			player.reading = true;
			_delay(2);
		5:
			pass;
