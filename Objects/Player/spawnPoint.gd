extends Node2D


# Declare member variables here. Examples:
export var myID = 0;
var player = "../obj_Player";
export var flipChar = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false;
	if(gvar.G_targetSpawn == myID):
		var myPlayer = get_node(player);
		myPlayer.position = position;
		if(flipChar):
			myPlayer.get_node("AnimatedSprite").flip_h = true;
		else:
			myPlayer.get_node("AnimatedSprite").flip_h = false;


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
