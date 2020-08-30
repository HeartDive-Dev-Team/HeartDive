extends Camera2D

# Declare member variables here. Examples:
var objPlayer;
var rootPos;
export var camMoveY = 180;
# Called when the node enters the scene tree for the first time.
func _ready():
	objPlayer = get_parent();
	rootPos = get_position();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(!objPlayer.reading and objPlayer.velocity.x == 0 and objPlayer.bolGround()):
		if(Input.is_action_pressed("ui_up")):
			smoothing_speed = 1;
			position.y = rootPos.y - camMoveY;
		elif(Input.is_action_pressed("ui_down")):
			smoothing_speed = 1;
			position.y = rootPos.y + camMoveY;
		else:
			smoothing_speed = 12;
			position.y = rootPos.y;
	else:
		smoothing_speed = 12;
		position.y = rootPos.y;
