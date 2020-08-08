extends Node2D


# Declare member variables here. Examples:
var roomGoto = "";
var defaultDelay = 60;
var delay = defaultDelay;
var active = false;


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(active):
		delay -= 1;
	if(delay <= 0):
		get_tree().change_scene(roomGoto);
		reset();
		
func activate(var room, var myDelay):
	active = true;
	roomGoto = room;
	delay = myDelay;

func reset():
	active = false;
	roomGoto = "";
	delay = defaultDelay;
