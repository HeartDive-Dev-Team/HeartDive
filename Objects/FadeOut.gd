extends Node2D


# Declare member variables here. Examples:
export var speed = 1;
var active = false;


# Called when the node enters the scene tree for the first time.
func _ready():
	pass;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(active):
		if(position.x > 0):
			position.x += speed;

func activate():
	active = true;
	visible = true;
