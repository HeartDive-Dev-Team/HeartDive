extends KinematicBody2D

const MULTIPLIER = 10;
const GRAVITY = 80 * MULTIPLIER
var WALKSPD = 8 * MULTIPLIER;
var velocity = Vector2()
var direction = "left";
var damageDealer = 1;
var health = 50;
var objetoColisionado;
var colisionando = false;
var contadorStun = 0;
var contadorInvencible = 0
onready var anims = get_node("AnimatedSprite");

var turning = false;

var mode = "normal" #Valid modes: "normal", "stun", "dead"
# Called when the node enters the scene tree for the first time.
func _ready():
	velocity.x = 0;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (colisionando == true and mode == "normal"):
		objetoColisionado.takeDamage(damageDealer) #Dañar al jugador
	
	if (contadorStun > 0):
		contadorStun -= 1
			
	if contadorInvencible > 0:
		contadorInvencible -= 1
	
	if(mode == "stun"):
		modulate.a = 0.5;
		if(contadorStun <= 0):
			mode = "normal";
			modulate.a = 1;
		if(is_on_floor()):
			velocity.x = 0;
	
	if!(is_on_floor()):
		velocity.y += delta * GRAVITY;
	else: #Reset all the variables when touching the ground
		velocity.y = 0;
		
	if (mode == "normal" and !turning):
		if(direction == "left"):
			velocity.x = -WALKSPD;
		else:
			velocity.x = WALKSPD;
			
		if(get_wall_side() == -1):
			direction = "right";
			if(!turning):
				turning = true;
				anims.init_turn()
		elif(get_wall_side() == 1):
			direction = "left";
			if(!turning):
				turning = true;
				anims.init_turn()
	velocity = move_and_slide(velocity, Vector2(0, 0));

func get_wall_side():
	if(get_node("colRight").is_colliding()):
		 return 1
	if(get_node("colLeft").is_colliding()):
		return -1
	return 0;

func die():
	queue_free();

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
	velocity.y = -150;
	if health <= 0:
		die();
		#contadorInvencible = 10;
