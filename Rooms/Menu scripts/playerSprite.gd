extends AnimatedSprite


# Declare member variables here. Examples:
var myOpacity = 0;


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(myOpacity < 1):
		myOpacity += 0.02;
	modulate.a = myOpacity;
