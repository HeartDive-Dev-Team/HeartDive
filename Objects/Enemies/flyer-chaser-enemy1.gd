extends KinematicBody2D


const MULTIPLIER = 10
var WALKSPD = 8 * MULTIPLIER;
var velocity = Vector2()
var direction = "left";
var ydirection = "up";
var damageDealer = 1;
var health = 50;
var objetoColisionado;
var colisionando = false;
var contadorStun = 0;
var contadorInvencible = 0
onready var anims = get_node("AnimatedSprite");

var player

var turning = false;
var chaseCounter = 0;
var chaseCounterCountdown = true
var mode = "normal" #Valid modes: "normal", "stun" "dead"
# Called when the node enters the scene tree for the first time.
func _ready():
	velocity.x = 0;
	velocity.y = -WALKSPD;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (colisionando == true and mode == "normal"):
		objetoColisionado.takeDamage(damageDealer) #Dañar al jugador
	
	if (contadorStun > 0):
		contadorStun -= 1
	
	if contadorInvencible > 0:
		contadorInvencible -= 1
	
	if(chaseCounter > 0 and chaseCounterCountdown):
		chaseCounter -= 1
	
	
	if(mode == "stun"):
		modulate.a = 0.5;
		if(contadorStun <= 0):
			mode = "normal";
			modulate.a = 1;
	
		
	if (mode == "normal" and !turning):
		if(direction == "left"):
			velocity.x = -WALKSPD;
		else:
			velocity.x = WALKSPD;
			
		if(get_wall_side() == -1):
			direction = "right";
			get_node("Area2D2").position.x = 175
			if(!turning):
				turning = true;
		elif(get_wall_side() == 1):
			direction = "left";
			get_node("Area2D2").position.x = -175
			if(!turning):
				turning = true;
	velocity = move_and_slide(velocity, Vector2(0, 0));
	
	if (get_y_side() == 1) and velocity.y > -WALKSPD/2:
		velocity.y -= 2
	elif(get_y_side() == -1 and velocity.y < WALKSPD/2):
		velocity.y += 2
	
	if (chaseCounter > 0):
		if (player.position.y > position.y and velocity.y < WALKSPD/2):
			velocity.y += 3
		if (player.position.y < position.y and velocity.y > -WALKSPD/2):
			velocity.y -= 3


func get_wall_side():
	if(get_node("colRight").is_colliding()):
		 return 1
	if(get_node("colLeft").is_colliding()):
		return -1
	return 0;

func die():
	queue_free();

func get_y_side():
	if (get_node("colTop").is_colliding()):
		return -1
	if (get_node("colBottom").is_colliding()):
		return 1
	return 0;

func _on_Area2D_body_entered(body):
	if(body.get_name() == "obj_Player"):
		objetoColisionado = body
		colisionando = true

func _on_Area2D_body_exited(body):
	if(body.get_name() == "obj_Player"):
		colisionando = false

func takeDamage(damageRecived, multiplier):
	health = health-damageRecived
	mode = "stun";
	contadorStun = 30;
	velocity.x = 10 * multiplier
	velocity.y = -125;
	if health <= 0:
		die();

func _on_Area2D2_body_entered(body):
	if (body.get_name() == "obj_Player"):
		player = body
		chaseCounter = 600;
		chaseCounterCountdown = false

func _on_Area2D2_body_exited(body):
	if (body.get_name() == "obj_Player"):
		chaseCounterCountdown = true
