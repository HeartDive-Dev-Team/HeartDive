extends KinematicBody2D

var health = 150;
var objetoColisionado;
var colisionando = false;
onready var anims = get_node("AnimatedSprite");
export var enemyToImport:String
#onready var enemy1;
# Called when the node enters the scene tree for the first time.
func _ready():
	#enemy1 = preload(enemyToImport);
	pass
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
