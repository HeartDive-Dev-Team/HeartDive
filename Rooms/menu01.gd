extends Node2D

# Declare member variables here. Examples:
# var a = 2
onready var FadeOut = get_node("CanvasLayer/FadeOut");
onready var bottomText = get_node("CanvasLayer/textoInicio");
export var roomGoto = "";
export(AudioStream) var roomSong;

# Called when the node enters the scene tree for the first time.
func _ready():
	MusicPlayer.stopSong();
	gvar.HUD_OFF();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("ui_accept") and !FadeOut.active):
		FadeOut.activate();
		bottomText.active = false;
		RoomChanger.activate(roomGoto, 120);
