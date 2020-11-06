extends KinematicBody2D

var health = 150;
var objetoColisionado;
var colisionando = false;
onready var anims = get_node("AnimatedSprite");
export var enemyToImport = 0
onready var enemy1 = EnemyTable.lista[enemyToImport];

var spawnerGeneratedCounter = 0

var active = true;
# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("enemies");

func _process(delta):
	pass

func die():
	queue_free();

func takeDamage(damageRecived, multiplier):
	health = health-damageRecived
	if health <= 0:
		die();

func generateEnemy():
	var e = enemy1.instance();
	e.position = position
	e.position.x += 0
	e.position.y -= 32;
	e.velocity.y = -300
	e.spawnerGenerated = true
	get_tree().get_root().add_child(e);


func _on_Timer_timeout():
	if(active):
		for node in get_tree().get_root().get_children():
			if "enemy" in node.get_name():
				if node.spawnerGenerated == true:
					spawnerGeneratedCounter += 1
		if (spawnerGeneratedCounter < 3):
			generateEnemy()
		spawnerGeneratedCounter = 0

