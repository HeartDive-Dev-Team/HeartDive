extends Node2D


# Declare member variables here. Examples:
var myOpacity = 0;
var active = false;
export var opacitySpeed = 0.05


# Called when the node enters the scene tree for the first time.
func _ready():
	pass;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(myOpacity < 1 and active):
		myOpacity += opacitySpeed;
	modulate.a = myOpacity;

func activate():
	visible = true;
	active = true;
