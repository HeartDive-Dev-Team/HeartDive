extends AnimatedSprite

var objPlayer;

var idle = "idle";
var walk = "walk";
var jump = "jump";
var fall = "fall";
var slide = "slide";
var flippable = true;
var gotHurt = -1;
var isDefaultAnims = false;

var punch1_number = 1;

# Called when the node enters the scene tree for the first time.
func _ready():
	objPlayer = get_parent();

func _process(delta):
	if objPlayer.inicioGolpeL:
		if (frame >= 1 and frame < 5):
			get_node("punchLhit/golpe").disabled = false
		else:
			get_node("punchLhit/golpe").disabled = true
	else:
			get_node("punchLhit/golpe").disabled = true
	
	if(flippable and !objPlayer.reading):
		if(objPlayer.intMove == 1):
			flip_h = false;
		elif(objPlayer.intMove == -1):
			flip_h = true;
	if(!objPlayer.bolGround() and objPlayer.velocity.y != 0):
		if(objPlayer.get_wall_side() == 0):
			if(objPlayer.velocity.y < -20):
				animation = jump;
			else:
				animation = fall;
		else:
			animation = slide;
			if(objPlayer.get_wall_side() == 1):
				flip_h = true;
			else:
				flip_h = false;
	else:
		if(objPlayer.velocity.x != 0 and objPlayer.bolGround()):
			animation = walk;
		else:
			animation = idle;
	
	#Getting hurt animation
	if(gotHurt > 0):
		gotHurt -= 1;
		#Red color
		if(gotHurt > 110):
			modulate = Color(1,0,0);
		else:
			modulate = Color(1,1,1);
		if(gotHurt < 110 and gotHurt > 108):
			defaultAnims();
		#Transparency effect
		if(gotHurt % 2 == 0):
			modulate.a = 0.1;
		else:
			modulate.a = 1;
	elif(gotHurt == 0):
		modulate.a = 1;
		gotHurt = -1;
	
	#Looking up or down animation
	if(!objPlayer.reading):
		if(Input.is_action_pressed("ui_up") and isDefaultAnims):
			idle = "idle_above";
			get_parent().get_node("Camera2D").cooldown -= 1;
		elif(Input.is_action_pressed("ui_down") and isDefaultAnims):
			idle = "idle_below";
			get_parent().get_node("Camera2D").cooldown -= 1;
		elif(isDefaultAnims):
			idle = "idle";
func getHurt():
	gotHurt = objPlayer.invencibleMAX;
	hurtAnims();
func defaultAnims():
	idle = "idle";
	walk = "walk";
	jump = "jump";
	fall = "fall";
	slide = "slide";
	flippable = true;
	isDefaultAnims = true;
func punchAnims():
	if(punch1_number == 1):
		idle = "punchL";
		walk = "punchL";
		jump = "punchL";
		fall = "punchL";
		punch1_number = 2;
	else:
		idle = "punchR";
		walk = "punchR";
		jump = "punchR";
		fall = "punchR";
		punch1_number = 1;
	flippable = false;
	frame = 0;
	isDefaultAnims = false;
func airPunchAnims(side):
	if(side == 0):
		idle = "punchAir";
		walk = "punchAir";
		jump = "punchAir";
		fall = "punchAir";
	flippable = false;
	frame = 0;
	isDefaultAnims = false;
func groundPoundAnims(value):
	if(value == 0):
		idle = "groundPound_1";
		walk = "groundPound_1";
		jump = "groundPound_1";
		fall = "groundPound_1";
	else:
		idle = "fall";
		walk = "fall";
		jump = "fall";
		fall = "fall";
	isDefaultAnims = false;
func dashAnims():
	idle = "dash";
	walk = "dash";
	jump = "jump";
	fall = "fall";
	flippable = false;
	isDefaultAnims = false;

func hurtAnims():
	idle = "hurt";
	walk = "hurt";
	jump = "hurt";
	fall = "hurt";
	slide = "hurt";
	flippable = false;
	isDefaultAnims = false;
	
func uppercutAnims():
	idle = "uppercut_1";
	walk = "uppercut_1";
	jump = "uppercut_1";
	fall = "uppercut_1";
	slide = "uppercut_1";
	flippable = false;
	isDefaultAnims = false;
