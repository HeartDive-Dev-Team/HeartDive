extends Node2D


# Declare member variables here. Examples:
export var roomGoto = ""; #Direccion en carpeta del cuarto a dirigirse
export(NodePath) var fadeOut;
var myFadeOut;
var countdown = 60;
var active = false;
export var targetSpawn = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	myFadeOut = get_node(fadeOut);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(active and countdown > 0):
		countdown -= 1;
	elif(countdown <= 0):
		get_tree().change_scene(roomGoto);

func _on_Area2D_body_entered(body):
	if(body.get_name() == "obj_Player"):
		active = true;
		myFadeOut.activate();
		body.reading = true;
		gvar.G_targetSpawn = targetSpawn;
