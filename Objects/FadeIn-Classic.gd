extends Node2D


# Declare member variables here. Examples:
var myOpacity = 1;


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = true;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(myOpacity > 0):
		myOpacity -= 0.02;
	modulate.a = myOpacity;
