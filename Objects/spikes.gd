extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
var damageDealer = 2;

var objetoColisionado;
var colisionando = false;
# Called when the node enters the scene tree for the first time.
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if colisionando == true:
		objetoColisionado.takeDamage(damageDealer)


func _on_Area2D_body_entered(body):
	if(collidableObjects(body)):
		objetoColisionado = body
		colisionando = true
	
func _on_Area2D_body_exited(body):
	if(collidableObjects(body)):
		colisionando = false

func collidableObjects(body):
	if(body.get_name() == "obj_Player" or body.get_name() == "companionTemplate"):
		return true;
	else:
		return false;
