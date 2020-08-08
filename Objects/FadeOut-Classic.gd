extends Node2D


# Declare member variables here. Examples:
var myOpacity = 0;
var active = false;


# Called when the node enters the scene tree for the first time.
func _ready():
	pass;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(myOpacity < 1 and active):
		myOpacity += 0.02;
	modulate.a = myOpacity;

func activate():
	visible = true;
	active = true;
