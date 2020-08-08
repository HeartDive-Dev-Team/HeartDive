extends Node2D


# Declare member variables here. Examples:
onready var handR = get_node("handR");
onready var handL = get_node("handL");
onready var torso = get_node("torsoFrames");

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func changeAnim(animation):
	handR.animation = animation;
	handL.animation = animation;
	torso.animation = animation;
	match animation:
		"default":
			handR.offset = Vector2(0, 0);
			handL.offset = Vector2(0, 0);
			torso.offset = Vector2(0, 0);
		"happy":
			handR.offset = Vector2(0, 0);
			handL.offset = Vector2(0, -8);
			torso.offset = Vector2(0, 0);
		"shocked":
			handR.offset = Vector2(-1, -1);
			handL.offset = Vector2(1, -1)
			torso.offset = Vector2(0, 0);
