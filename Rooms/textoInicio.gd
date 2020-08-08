extends Label


# Declare member variables here. Examples:
export var timerOnOff = 0;
var timerCount = 0;
var active = true;


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(active):
		if(timerCount < timerOnOff):
			timerCount += 1;
		if(timerCount >= timerOnOff):
			timerCount = 0;
			visible = !visible
	else:
		visible = false;
