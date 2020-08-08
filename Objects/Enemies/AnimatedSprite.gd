extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var myself = get_parent();
var turningCount = 0;
var turningFrames = 15;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(!myself.turning):
		animation = "default";
		if(get_parent().direction == "left"):
			flip_h = false;
		else:
			flip_h = true;
	else:
		animation = "turn";
		turningCount -= 1;
		if(turningCount <= 0):
			myself.turning = false;

func init_turn():
	turningCount = turningFrames;
