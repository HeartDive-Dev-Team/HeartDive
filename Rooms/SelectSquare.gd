extends AnimatedSprite


# Declare member variables here. Examples:
var desiredPosY = 0;
export var velocity = 10;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(position.y != desiredPosY):
		position.y = desiredPosY;

func changeIndex(var value):
	desiredPosY = value;
