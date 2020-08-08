extends Node2D


# Declare member variables here. Examples:
export var roomGoto = ""; #Direccion en carpeta del cuarto a dirigirse

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if(body.get_name() == "obj_Player"):
		get_tree().change_scene(roomGoto);
