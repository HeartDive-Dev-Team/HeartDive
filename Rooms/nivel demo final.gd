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
			MusicPlayer.stopSong();
			_delay(100);
		1:
			showMessage("Well, this is as far as this demo goes.");
			_delay(0);
		2:
			showMessage("However, you are free to go into the Debug Room if you want to :D");
			_delay(0);
		3:
			showMessage("See you around!");
			_delay(0);
		4:
			player.reading = false;
