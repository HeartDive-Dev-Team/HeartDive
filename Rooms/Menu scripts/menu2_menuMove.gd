extends TileMap


# Declare member variables here. Examples:
var desiredOff = 32;
var i = 0;
var startPos;

# Called when the node enters the scene tree for the first time.
func _ready():
	startPos = position;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(i < desiredOff):
		i += 1;
		position.y += 1;
	else:
		position = startPos;
		i = 0;
