extends KinematicBody2D

var health = 150;
var objetoColisionado;
var colisionando = false;
onready var anims = get_node("AnimatedSprite");
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	pass

func die():
	queue_free();

func takeDamage(damageRecived, multiplier):
	health = health-damageRecived
	if health <= 0:
		die();
		#contadorInvencible = 10;


