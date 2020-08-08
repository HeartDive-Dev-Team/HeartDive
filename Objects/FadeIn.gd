extends Node2D


# Declare member variables here. Examples:
export var speed = -1;
export var active = true;
var finished = false;


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = true;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(position.x > -1000 and active):
		position.x += speed;
	else:
		finished = true;
