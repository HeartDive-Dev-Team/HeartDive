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
var observing = false;

var coyote = 0;
var coyoteMAX = 20;
var jumped = false;
var bolDobleSalto = true;
onready var jumpBuffer = get_node("jumpBuffer");
onready var misile = preload("res://Objects/player_misile.tscn")
var WJUMPonwall = false;

var habilidadCooldown = 0;

var basicDMGdealer = 25

var tieneControl = true
var dashSide = 0;
var dashTimeMAX = 18;
var dashTime = 0;
var dashAble = true;
var dashCooldownMAX = 90;
var dashCooldown = 0;

var inicioGolpeL = false
var isAirPunch = false;

var pounding = true;
var poundCount = 1;
var gpPhase = 0;
var gpPhase_1_time = 30;
var gpPhase_1_timer = 0;
var splashing = false;
var splashTime = 5;
var splashTimer = 0;

var keyLeft = 0;
var keyRight = 0;
var intMove = 0;

var uppercutting = false;
var uppercutPhase = -1;
var uppercutTimer = 0;

var invencible = 0;
var invencibleMAX = 120;
var stun = 0;

onready var jumpSFX = get_node("jumpSFX");
onready var myAnims = get_node("AnimatedSprite");

func _ready():
	startPos = get_position();
	velocity.x = 0;
	velocity.y = 0;
	MAX_SPEED = WALKSPD;

#intMove implementation:------------------------------------------
func _intMoveProceso():

	if Input.is_action_pressed("ui_left"):
		keyLeft = -1;
	else:
		keyLeft = 0;
	if Input.is_action_pressed("ui_right"):
		keyRight = 1;
	else:
		keyRight = 0;
	if(Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_left")):
		keyLeft = 0;
		keyRight = 0;
#Step Event:--------------------------------------------------------------
func _physics_process(delta):
	_intMoveProceso();
	if(intMove != 0):
		facingDirection = intMove;
	checkInvencible();
	intMove = keyLeft + keyRight;
	#Gravity
	if(!is_on_floor() or !bolGround()):
		velocity.y += GRAVITY * delta;
		#Coyote Time
		if(coyote > 0):
			coyote -= 1;
	else: #Reset all the variables when touching the ground
		#velocity.y = 0;
		dashAble = true;
		if(!pounding and poundCount <= 0):
			pounding = true;
			poundCount = 1;
		coyote = coyoteMAX;
		jumped = false;
		bolDobleSalto = true;
		dashAble = true;
		dashTime = 0;
		dashCooldown = 0;
		
	#Basic Jumping //////////////////////////////////////////
	if(reading == false):
		if Input.is_action_just_pressed("keyS") and (is_on_floor() or coyote > 0) and !jumped:
			jump(JUMP_SPEED);
			jumped = true;
			if(coyote > 0):
				coyote = 1;
		elif(!is_on_floor() or !bolGround()):
			jumpBuffer.start();
		if(Input.is_action_pressed("keyS") and (is_on_floor() or bolGround()) and !jumped and !jumpBuffer.is_stopped()):
			jump(JUMP_SPEED);
			jumpBuffer.stop();
			jumped = true;
		
		if(Input.is_action_just_released("keyS") and velocity.y < 0):
			velocity.y = velocity.y / 2;
		if Input.is_action_just_pressed("keyS") and !bolGround() and bolDobleSalto and get_wall_side() == 0 and coyote <= 0:
			dobleSalto();
	
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
	
	if(gvar.G_playerWalljump and !reading):
		#Walljump (Complex)//////////////////////////////////
		#Conditions: Phase 1----
		if(!is_on_floor() and !bolGround() and get_wall_side()):
			if(velocity.y > 150 and intMove != 0):
				velocity.y = 150;
			if(Input.is_action_just_pressed("keyS")):
				velocity.y = -JUMP_SPEED * 0.7;
				velocity.x = -RUNSPD * get_wall_side();
				$kickSFX.play();
	
	#DEBUG:
	#Reset position
	if(Input.is_action_just_pressed("ui_cancel")):
		#die();
		pass;
	#Misile-------------------
	#if (Input.is_action_pressed("keyShoot") and bolGround() and gvar.G_playerStamina >= 25):
	#	velocity.x = 0
	#if (Input.is_action_just_released("keyShoot") and bolGround() and gvar.G_playerStamina >= 25):
	#	createMisile()
	#Uppercut /////////////////////////////////////////
	if(Input.is_action_pressed("ui_up") and Input.is_action_pressed("keyA") and bolGround() and !isUsingAbility() and gvar.G_playerStamina >= 50 and !uppercutting):
		uppercut()
	if (uppercutting):
		if (velocity.x > 100):
			velocity.x = 100
		if (velocity.x < -100):
			velocity.x = -100;
	#Phase 0:--------------
		if(uppercutPhase == 0 and uppercutTimer > 0):
			velocity.y = 0;
			uppercutTimer -= 1;
		elif(uppercutPhase == 0):
			uppercutPhase = 1;
			jump(700);
	if (velocity.y >= 0 and uppercutting and uppercutPhase == 1):
		get_node("AnimatedSprite/uppercutHit/gpUpper").disabled = true
		uppercutting = false
		if(myAnims.jump == "uppercut_1"):
			myAnims.defaultAnims();
	#Golpe 1///////////////////////////////////////////
	if(reading == false):
		if Input.is_action_just_pressed("keyD") and !Input.is_action_pressed("ui_up"):
			if(habilidadCooldown <= 0):
				dar_golpe1(false); #Don't skip the usage check
			elif(habilidadCooldown >= 1 and myAnims.punch1_number == 2):
				dar_golpe1(true); #Skip it
	
		#Dashear//////////////////////////////////////////
		if (Input.is_action_just_pressed("keyShift") and gvar.G_playerDash and intMove != 0 and dashAble and dashCooldown <= 0):
			Dashear()
		if(!tieneControl and dashTime > 0):
			Dasheando();
		if(dashCooldown > 0):
			dashCooldown -= 1;
		#Ground Pound//////////////////////////////////////
		if(gpPhase == 0): #Extra checks to prevent the infinite damage exploit
			if(get_node("AnimatedSprite/gpHit/gpSplash").disabled == false):
				get_node("AnimatedSprite/gpHit/gpSplash").disabled = true;
				get_node("AnimatedSprite/gpHit/gpGolpe").disabled = true;
		if(Input.is_action_pressed("keyA") and Input.is_action_pressed("ui_down") and pounding and !isUsingAbility() and poundCount > 0 and !bolGround() and gvar.G_playerStamina >= 20):
			groundPound();
		elif(!pounding):
			#Phase 1: Float in mid-air
			if(gpPhase == 1):
				if(!$gpSFX_1.playing):
					$gpSFX_1.play();
				velocity.y = 0;
				velocity.x = 0;
				if(gpPhase_1_timer > 0):
					gpPhase_1_timer -= 1;
				else:
					gpPhase = 2;
			#Phase 2: Drop to the floor
			if(gpPhase == 2):
				if(!$gpSFX_2.playing):
					$gpSFX_2.play();
				myAnims.groundPoundAnims(1);
				invencible = invencibleMAX/4;
				velocity.y = JUMP_SPEED * 2;
				if(bolGround() or is_on_floor()):
					velocity.y = -JUMP_SPEED * 0.5;
					myAnims.defaultAnims();
					$gpSFX_3.play();
					if(intMove != 0):
						velocity.x =  facingDirection * RUNSPD * 2.5;
					poundCount -= 1;
					gpPhase = 0;
					splashing = true;
					splashTimer = splashTime;
			if(splashing):
				if(splashTimer > 0):
					splashTimer -= 1;
					get_node("AnimatedSprite/gpHit/gpGolpe").disabled = false;
					get_node("AnimatedSprite/gpHit/gpSplash").disabled = false;
				else:
					get_node("AnimatedSprite/gpHit/gpGolpe").disabled = true;
					get_node("AnimatedSprite/gpHit/gpSplash").disabled = true;
	#Apply using move and slide
	velocity = move_and_slide(velocity, Vector2(0, -1))
		
#Collision and interaction with every single object in the game (?)
func _process(delta):
	get_node("Camera2D/CanvasLayer/LEvida").set_text("HP: " + str(gvar.G_playerHealth))
	get_node("Camera2D/CanvasLayer/LEinvencible").set_text(str(coyote) + " :Coyote")
	
	if(gvar.G_playerStamina <100 and bolGround()):
		gvar.G_playerStamina += 0.5
	if (gvar.G_playerStamina < 0):
		gvar.G_playerStamina = 0
	
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
		myAnims.punch1_number = 1;
		velocity.x = 0;
		get_node("AnimatedSprite/punchLhit/golpe").scale.y = 1;
		get_node("AnimatedSprite/punchLhit/golpe").scale.x = 1;
	if (intMove == 1 and habilidadCooldown <= 0):
		get_node("AnimatedSprite/punchLhit/golpe").position.x = 4
	elif (intMove == -1 and habilidadCooldown <= 0):
		get_node("AnimatedSprite/punchLhit/golpe").position.x = -4
	get_node("AnimatedSprite/uppercutHit/gpUpper").position.x = 6*facingDirection

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

func die():
	position = startPos
	# ir a escena transición con cartel luminoso de moriste jaja que wacho
	# position = tablaCheckpoints[idCheckpoint].position
	gvar.G_playerHealth = gvar.G_MAXHealth;
	SceneManager.reloadScene();
	
func takeDamage (cantDamage):
	if invencible == 0:
		gvar.G_playerHealth -= cantDamage
		invencible = invencibleMAX
		myAnims.getHurt();
		$gotHurtSFX.play();
		velocity.x = -200 * facingDirection;
		velocity.y = -300;
		if gvar.G_playerHealth <= 0:
			die()

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
		tieneControl = false
		inicioGolpeL = true
		habilidadCooldown = 25
		if(bolGround()):
			velocity.x = RUNSPD * 1.1 * facingDirection;
			get_node("AnimatedSprite").punchAnims();
			isAirPunch = false;
		else:
			get_node("AnimatedSprite").airPunchAnims(0);
			isAirPunch = true;
		$punchSFX_3.play();

func reiniciarInicioHabilidades():
	inicioGolpeL = false

func Dashear():
	if(!isUsingAbility()):
		dashAble = false;
		tieneControl = false;
		dashTime = dashTimeMAX;
		dashSide = intMove;
		$dashSFX.play();

func Dasheando():
	if(dashTime > 1):
		get_node("AnimatedSprite").dashAnims();
		tieneControl = false;
		dashTime -= 1;
		velocity.x = 600 * dashSide;
		velocity.y = 0;
	if((dashTime <= 1 or is_on_wall()) or Input.is_action_just_pressed("keyS")): #Go back to normal
		tieneControl = true;
		dashTime = 0;
		intMove = dashSide;
		get_node("AnimatedSprite").defaultAnims();
		dashSide = 0;
		dashAble = true;
		dashCooldown = dashCooldownMAX;
		if(Input.is_action_just_pressed("keyS")):
			velocity.y = -JUMP_SPEED;

func _on_punchLhit_area_entered(area):
	if ("enemy" in area.get_parent().get_name() and "hurtBox" in area.get_name()):
		if(position.x > area.get_parent().position.x):
			area.get_parent().takeDamage(basicDMGdealer, -15);
		else:
			area.get_parent().takeDamage(basicDMGdealer, 15);
		var rand = rand_range(0, 10);
		if(rand < 5):
			$punchSFX_2.play();
		else:
			$punchSFX_1.play();

func groundPound():
	pounding = false;
	gpPhase = 1;
	gpPhase_1_timer = gpPhase_1_time;
	get_node("AnimatedSprite/gpHit/gpGolpe").disabled = false;
	myAnims.groundPoundAnims(0);
	$gpSFX_1.playing = false;
	$gpSFX_2.playing = false;
	gvar.G_playerStamina -= 20
	#if(velocity.x == 0):
		#velocity.x = facingDirection * 100;

func isUsingAbility():
	if(reading or dashTime >= 1 or inicioGolpeL or !pounding):
		return true;
	else:
		return false;

func jump(force):
	velocity.y = -force;
	jumpSFX.play();

func dobleSalto():
	jump(JUMP_SPEED * 0.8);
	bolDobleSalto = false
	
func setStun(stunAmount):
	stun = stunAmount;

func createMisile():
	var e = misile.instance()
	e.position = position
	e.velocity.x = 0
	e.velocity.y = 0
	if (Input.is_action_pressed("ui_up")):
		e.velocity.y -= 30
	elif (Input.is_action_pressed("ui_down")):
		e.velocity.y += 30
	if (Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left")):
		e.velocity.x = 30 * facingDirection
	if (!Input.is_action_pressed("ui_up") and !Input.is_action_pressed("ui_down") and !Input.is_action_pressed("ui_right") and !Input.is_action_pressed("ui_left")):
		e.velocity.x = 30 * facingDirection
	get_tree().get_root().add_child(e)
	gvar.G_playerStamina -= 25

func _on_gpHit_area_entered(area):
	if ("enemy" in area.get_parent().get_name() and "hurtBox" in area.get_name()):
		area.get_parent().takeDamage(basicDMGdealer, 0);
		$punchSFX_2.play();

func uppercut():
	get_node("AnimatedSprite/uppercutHit/gpUpper").disabled = false
	uppercutting = true
	gvar.G_playerStamina -= 50
	myAnims.uppercutAnims();
	uppercutPhase = 0;
	uppercutTimer = 15;


func _on_uppercutHit_area_entered(area):
	if ("enemy" in area.get_parent().get_name() and "hurtBox" in area.get_name()):
		if(position.x > area.get_parent().position.x):
			area.get_parent().takeDamage(basicDMGdealer * 2, -10);
		else:
			area.get_parent().takeDamage(basicDMGdealer * 2, 10);
		$punchSFX_2.play();
