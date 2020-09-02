extends KinematicBody2D

var health = 150;
var objetoColisionado;
var colisionando = false;
onready var anims = get_node("AnimatedSprite");
var enemy1 = preload ("res://Objects/Enemies/enemy1.tscn");

# Called when the node enters the scene tree for the first time.
func _ready():
	generateEnemy()

func _process(delta):
	pass

func die():
	queue_free();

func takeDamage(damageRecived, multiplier):
	health = health-damageRecived
	if health <= 0:
		die();
		

func generateEnemy():
	var e = enemy1.instance()
	e.position = position
	e.position.x += 96
	e.velocity.y = -300
	get_tree().get_root().add_child(e)


func _on_Timer_timeout():
	generateEnemy()
