extends Node2D


# Declare member variables here. Examples:
var velocity = 0;
var maxVelocity = 0.1;
var phase = 0;


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(phase == 0):
		if(velocity < maxVelocity):
			velocity += 0.001;
		else:
			phase = 1;
	else:
		if(velocity > -maxVelocity):
			velocity -= 0.001;
		else:
			phase = 0;
	
	position.y = position.y + velocity;
