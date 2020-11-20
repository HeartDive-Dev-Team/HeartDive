extends KinematicBody2D
#Create Event:

const MULTIPLIER = 10;
const GRAVITY = 120 * MULTIPLIER;
const WALK_SPEED = 3.5 * MULTIPLIER;
const JUMP_SPEED = 65 * MULTIPLIER;
var RUNSPD = 26 * MULTIPLIER;
var WALKSPD = 10 * MULTIPLIER;
var MAX_SPEED;
var velocity = Vector2()
var touching_wall = false;
var startPos;
var reading = false;
var facingDirection = -1;

var jumped = false;
var doubleJump = true;

var habilidadCooldown = 0;

var basicDMGdealer = 25

var inicioGolpeL = false
var isAirPunch = false;

var keyLeft = 0;
var keyRight = 0;
var intMove = 0;

var invencible = 0;
var invencibleMAX = 120;
var stun = 0;

onready var myAnims = get_node("AnimatedSprite");
export(NodePath) var playerPath;
var playerObject;
var distanceToPlayer = 85;

var timeFarAwayMAX = 300;
var timeFarAway = 0;

var jumpTimerMAX = 5;
var jumpTimer = 0;

func _ready():
	startPos = get_position();
	velocity.x = 0;
	velocity.y = 0;
	MAX_SPEED = WALKSPD;
	playerObject = get_node(playerPath);

#intMove implementation:------------------------------------------
#func _intMoveProceso():
#
#	if Input.is_action_pressed("ui_left"):
#		keyLeft = -1;
#	else:
#		keyLeft = 0;
#	if Input.is_action_pressed("ui_right"):
#		keyRight = 1;
#	else:
#		keyRight = 0;
#	if(Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_left")):
#		keyLeft = 0;
#		keyRight = 0;
#Step Event:--------------------------------------------------------------
func _physics_process(delta):
	#_intMoveProceso();
	if(intMove != 0):
		facingDirection = intMove;
	#Gravity
	if(!is_on_floor() or !bolGround()):
		velocity.y += GRAVITY * delta;
	else: #Reset all the variables when touching the ground
		#velocity.y = 0;
		jumped = false;
		doubleJump = true;
		jumpTimer = jumpTimerMAX;
		
	#Basic Jumping //////////////////////////////////////////
	if(reading == false):
		#Basic jumping follow, I'll jump right after my master jumps
		if isFarFromPlayerY(32) == -1 and !jumped and bolGround() and Input.is_action_just_released("keyS"):
				jump(JUMP_SPEED);
				jumped = true;
		#Try to follow player if he's way above me
		if isFarFromPlayerY(128) == -1 and !jumped and bolGround() and isFarFromPlayerX(distanceToPlayer*2) == 0 and !$upperEye_U.is_colliding():
				jump(JUMP_SPEED);
				jumped = true;
		#Double jump, used rarely
		if isFarFromPlayerY(32) == -1 and jumped and !bolGround() and velocity.y > -1 and doubleJump:
				jump(JUMP_SPEED);
				doubleJump = false;
		
		#If I'm very far and there's like a giant pit, I'll jump at the last second to try and reach Player
		if isFarFromPlayerX(distanceToPlayer*2) != 0 and !jumped and isFarFromPlayerY(32) == 1 and !bolGround():
			jump(JUMP_SPEED);
			jumped = true;
		
		#Try to jump over walls blocking my path
		if(isFarFromPlayerX(distanceToPlayer) and get_wall_side() != 0 and !jumped and bolGround()):
			jump(JUMP_SPEED);
			jumped = true;
		
		#Try to jump over pits
		#I won't jump if my master is below me on an 8 pixel radius
		if(isFarFromPlayerX(distanceToPlayer) != 0 and bolGround() and !jumped and isFarFromPlayerY(8) == 0):
			if(intMove == 1):
				if($leftEye_D.is_colliding() and !$rightEye_D.is_colliding()):
					jump(JUMP_SPEED);
					jumped = true;
			if(intMove == -1):
				if(!$leftEye_D.is_colliding() and $rightEye_D.is_colliding()):
					jump(JUMP_SPEED);
					jumped = true;
					
		#Jump at the last second
		#Player is in the air above me
		if(isFarFromPlayerY(distanceToPlayer/2) == -1 and !bolGround() and !jumped):
			jump(JUMP_SPEED);
			jumped = true;
#		#Player is in the air below or at my same altitude
#		if(isFarFromPlayerY(distanceToPlayer/2) != -1 and !bolGround() and !jumped):

	
		#Moving (Simplified) ////////////////////////////////
		if(!isUsingAbility()):
			if (intMove == -1 and velocity.x > -MAX_SPEED):
				velocity.x += -WALK_SPEED * delta * 60
			elif (intMove == 1 and velocity.x < MAX_SPEED):
				velocity.x +=  WALK_SPEED * delta * 60
			elif((bolGround() or is_on_floor()) or (!bolGround() and intMove == 0)):
				velocity.x -= WALK_SPEED * sign(velocity.x) * delta * 60;
		else:
			if(!bolGround()):
				if (intMove == -1 and velocity.x > -MAX_SPEED):
					velocity.x += -WALK_SPEED
				elif (intMove == 1 and velocity.x < MAX_SPEED):
					velocity.x +=  WALK_SPEED
			else:
				velocity.x -= WALK_SPEED * sign(velocity.x);
	#Limiter
	#if(velocity.x > MAX_SPEED):
	#	velocity.x = MAX_SPEED;
	#if(velocity.x < -MAX_SPEED):
	#	velocity.x = -MAX_SPEED;
	#Reduce position bugs
	if(velocity.x <= WALK_SPEED - 0.1 and velocity.x >= -WALK_SPEED + 0.1):
		velocity.x = 0;
	
	#Running by pressing A----------------------
	if(reading == false): #IMPORTANT: READING DISABLES MOVEMENT!!!!!!!!!!!
		MAX_SPEED = RUNSPD;
	elif(reading == true and MAX_SPEED != 0):
		MAX_SPEED = 0;
		velocity.x = 0;
		velocity.y = 0;
		myAnims.defaultAnims();

	#Golpe 1///////////////////////////////////////////
#	if(reading == false):
#		if Input.is_action_just_pressed("keyD") and !Input.is_action_pressed("ui_up"):
#			if(habilidadCooldown <= 0):
#				dar_golpe1(false); #Don't skip the usage check
#			elif(habilidadCooldown >= 1 and myAnims.punch1_number == 2):
#				dar_golpe1(true); #Skip it

	#########################################
	#	BASIC COMPANION SCRIPT				#
	#########################################
	isFarAway();
	#Basic following, on the floor
	if(bolGround()):
		if(isFarFromPlayerX(distanceToPlayer) == 1):
			intMove = 1;
		elif(isFarFromPlayerX(distanceToPlayer) == -1):
			intMove = -1;
		else:
			intMove = 0;
	#In the air, I will try to get closer to player since
	#he will probably land somewhere safe
	#However, I will not change my direction
	#drastically to avoid falling
	else:
		if(isFarFromPlayerX(0) == 1):
			if(intMove != -1):
				intMove = 1;
			else:
				intMove = 0;
		elif(isFarFromPlayerX(0) == -1):
			if(intMove != 1):
				intMove = -1;
			else:
				intMove = 0;
		#This is to prevent myself from
		#randomly dropping off cliffs.
		if(isFarFromPlayerX(distanceToPlayer/2) == 0 and isFarFromPlayerY(0) == 1):
			intMove == 0;
	#If the player is far vertically, but not horizontally enough, I will try to find my way by moving horizontally anyways
	#This first condition makes me drop out if my master is too far below
	if(isFarFromPlayerY(distanceToPlayer/10) == 1):
		if(bolGround()):
			if !$leftEye_D.is_colliding():
				intMove = -1;
			elif !$rightEye_D.is_colliding():
				intMove = 1;
	#This second condition helps me reach my master when he's on a block above me.
	#I might need to make some tricky moves to get there tho
	if($upperEye_U.is_colliding() and isFarFromPlayerX(distanceToPlayer) == 0 and isFarFromPlayerY(distanceToPlayer/2) != 0):
		if(!$upperEye_L.is_colliding()):
			intMove = -1;
		elif(!$upperEye_R.is_colliding()):
			intMove = 1;
		
		
	#Apply using move and slide
	velocity = move_and_slide(velocity, Vector2(0, -1))
		
#Collision and interaction with every single object in the game (?)
func _process(delta):
	#Invencible
	if invencible > 0:
		invencible -= 1;
	if(inicioGolpeL and bolGround()):
		if (facingDirection == -1):
			velocity.x += -WALK_SPEED * 0.7 * delta * 60
		else:
			velocity.x += WALK_SPEED * 0.7 * delta * 60
	if(inicioGolpeL and isAirPunch):
		if(bolGround()):
			habilidadCooldown = 0; #Si tocas el piso al hacer un air, se cancela
		get_node("AnimatedSprite/punchLhit/golpe").position.x = 0;
		get_node("AnimatedSprite/punchLhit/golpe").scale.y = 1.3;
		get_node("AnimatedSprite/punchLhit/golpe").scale.x = 1.3;
	#Countdown
	if (habilidadCooldown > 0):
		habilidadCooldown -= 1
	elif(habilidadCooldown == 0):
		reiniciarInicioHabilidades()
		get_node("AnimatedSprite").defaultAnims();
		habilidadCooldown = -1;
		velocity.x = 0;
		get_node("AnimatedSprite/punchLhit/golpe").scale.y = 1;
		get_node("AnimatedSprite/punchLhit/golpe").scale.x = 1;
	if (intMove == 1 and habilidadCooldown <= 0):
		get_node("AnimatedSprite/punchLhit/golpe").position.x = 4
	elif (intMove == -1 and habilidadCooldown <= 0):
		get_node("AnimatedSprite/punchLhit/golpe").position.x = -4

func get_wall_side():
	if(get_node("colRight").is_colliding()):
		 return 1
	if(get_node("colLeft").is_colliding()):
		return -1
	return 0;

func bolGround():
	if(get_node("colFloor").is_colliding()):
		return true
	return false
	
func takeDamage (cantDamage):
	if invencible == 0:
		invencible = invencibleMAX
		myAnims.getHurt();
		velocity.x = -200 * facingDirection;
		velocity.y = -300;

func checkInvencible():
	if invencible > 0:
		invencible -= 1

func _on_wallCheck_body_entered(body):
	pass
	#if(body.get_name() != "obj_Player"): #The sacred function, get_name()
	#	touching_wall = true;
func _on_wallCheck_body_exited(body):
	pass
	#touching_wall = false;

func dar_golpe1(skipCheck):
	if(!isUsingAbility() or skipCheck == true):
		#if(bolGround()):
		inicioGolpeL = true
		habilidadCooldown = 25
		if(bolGround()):
			velocity.x = RUNSPD * 1.1 * facingDirection;
			get_node("AnimatedSprite").punchAnims();
			isAirPunch = false;
		else:
			get_node("AnimatedSprite").airPunchAnims(0);
			isAirPunch = true;

func reiniciarInicioHabilidades():
	inicioGolpeL = false

func _on_punchLhit_area_entered(area):
	if ("enemy" in area.get_parent().get_name() and "hurtBox" in area.get_name()):
		if(position.x > area.get_parent().position.x):
			area.get_parent().takeDamage(basicDMGdealer, -15);
		else:
			area.get_parent().takeDamage(basicDMGdealer, 15);
#		var rand = rand_range(0, 10);
#		if(rand < 5):
#			$punchSFX_2.play();
#		else:
#			$punchSFX_1.play();

func isUsingAbility():
	if(reading or inicioGolpeL):
		return true;
	else:
		return false;

func jump(force):
	velocity.y = -force;

	
func setStun(stunAmount):
	stun = stunAmount;

func isFarFromPlayerX(distance):
	#This function tells me if I'm horizontally far away
	#from my master.
	#Player is far from the right
	if(playerObject.position.x > position.x + distance):
		return 1;
	#Player is far from the left
	elif(playerObject.position.x < position.x - distance):
		return -1;
	#He's close to me, no need to move
	else:
		return 0;
func isFarFromPlayerY(distance):
	#This function tells me if I'm vertically far away
	#from my master.
	#He's jumping above me
	if(playerObject.position.y < position.y - distance):
		return -1;
	#He's below me
	elif(playerObject.position.y > position.y + distance):
		return 1;
	else:
		return 0;

func isFarAway():
	#This function will make me teleport if I'm far away from
	#my master for too long
	#Generally, vertical unalignment triggers this, since
	#being horizontally sincronized is not as important.
	#However, being far away in the Y axis means that
	#my master might be somewhere I can't reach
	if(isFarFromPlayerY(distanceToPlayer) != 0 and isFarFromPlayerX(distanceToPlayer)):
		timeFarAway += 1;
	if(!$VisibilityNotifier2D.is_on_screen()):
		timeFarAway += 2;
	
	if(timeFarAway >= timeFarAwayMAX):
		position = playerObject.position;
		timeFarAway = 0;
	


func _on_jumpTimer_timeout():
	jump(JUMP_SPEED);
	jumped = true;
