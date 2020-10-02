extends Camera2D

# Declare member variables here. Examples:
var objPlayer;
var rootPos;
export var camMoveY = 180;
var cooldownMAX = 30;
var cooldown = 0;
# Called when the node enters the scene tree for the first time.
func _ready():
	objPlayer = get_parent();
	rootPos = get_position();
	cooldown = cooldownMAX;
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(!objPlayer.reading and objPlayer.velocity.x == 0 and objPlayer.bolGround() and cooldown <= 0):
		if(Input.is_action_pressed("ui_up")):
			smoothing_speed = 1;
			position.y = rootPos.y - camMoveY;
			
		elif(Input.is_action_pressed("ui_down")):
			smoothing_speed = 1;
			position.y = rootPos.y + camMoveY;
		else:
			smoothing_speed = 12;
			position.y = rootPos.y;
			cooldown = cooldownMAX;
	else:
		smoothing_speed = 12;
		position.y = rootPos.y;
