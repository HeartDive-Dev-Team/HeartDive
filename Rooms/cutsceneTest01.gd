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
			_delay(100);
		1:
			changePortrait(portraits[0]);
			changeAnimation("OlimacEdgy");
			changeVoice(voices[0]);
			changeName("Olimac31")
			showMessage("Hey.");
			_delay(0);
		2:
			showMessage("You shouldn't be here...");
			_delay(0);
		3:
			showMessage("But since you are...");
			_delay(0);
		4:
			changeAnimation("OlimacDefault")
			showMessage("I will have to congratulate you for learning how to Air-Dash!");
			_delay(0);
		5:
			showMessage("Also, if you're the first person to achieve this, take a screenshot and send it to the Discord server.");
			_delay(0);
		6:
			changeAnimation("OlimacJoyful")
			showMessage("I'll give you a cool prize for that! :D");
			_delay(0);
		7:
			player.velocity.x = 300;
			_delay(60);
		8:
			player.reading = false;
			_delay(2);
		9:
			pass;
