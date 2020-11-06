extends "res://Objects/CutsceneSystem.gd"


# Declare member variables here. Examples:
onready var player = get_node("playerDie");
onready var text = get_node("CutsceneSystem-TextHandler/CanvasLayer/textBox");
onready var cam = get_node("obj_Player/Camera2D");
export var portraits = [];
export var voices = [];
export var roomGoto = "";


# Called when the node enters the scene tree for the first time.
func _ready():
	gvar.HUD_OFF();
	MusicPlayer.stopSong();
	#$hurt.play();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match(scenePhase):
		0:
			player.animation = "default";
			player.position = Vector2(432, 240);
			if(i % 5 == 0):
				player.modulate = Color(1,0,0);
			else:
				player.modulate = Color(1,1,1);
			_delay(90);
		1:
			_delay(30);
		2:
			$explode.play();
			_delay(0);
		3:
			player.modulate = Color(1,1,1);
			player.animation = "explode";
			_delay(60);
		4:
			player.visible = false;
			_delay(120);
		5:
			gvar.HUD_ON();
			MusicPlayer.changeSong(gvar.G_preDeathSong);
			if(gvar.G_preDeathRoom != ""):
				RoomChanger.activate(gvar.G_preDeathRoom, 0);
			else:
				RoomChanger.activate("res://Rooms/menu01.tscn", 0);
			_delay(0);
		6:
			pass;
