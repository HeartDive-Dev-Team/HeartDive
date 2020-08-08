extends Area2D

var move = Vector2();
var intMove = 0;
var VXMax = 3;
var myAcc = 0.5;
var myVX = 0;

var keyLeft = 0;
var keyRight = 0;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#intMoveProceso pasa los bools del Input a Int para usarlos en intMove
func _intMoveProceso():
	if Input.is_action_pressed("ui_left"):
		keyLeft = -1;
	else:
		keyLeft = 0;
	if Input.is_action_pressed("ui_right"):
		keyRight = 1;
	else:
		keyRight = 0;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move.x = 0;
	move.y = 0;
	_intMoveProceso();
	intMove = keyLeft + keyRight;

	if(intMove != 0): #Acelerar
			myVX += myAcc * sign(intMove);
	else:
		if(myVX > 0):
			myVX -= myAcc;
		if(myVX < 0):
			myVX += myAcc;
	if(myVX > VXMax):
		myVX = VXMax;
	if(myVX < -VXMax):
		myVX = -VXMax;
	move.x = myVX;
	for i in abs(myVX):
		position += Vector2(sign(int(myVX)), 0);
