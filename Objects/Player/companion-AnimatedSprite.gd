extends AnimatedSprite

var objMyself;

var prefix = "0-"
var idle = "idle";
var walk = "walk";
var jump = "jump";
var fall = "fall";
var flippable = true;
var gotHurt = -1;
var isDefaultAnims = false;

var punch1_number = 1;

# Called when the node enters the scene tree for the first time.
func _ready():
	objMyself = get_parent();
	defaultAnims();

func _process(delta):
	
#	if objMyself.inicioGolpeL:
#		if (frame >= 1 and frame < 5):
#			get_node("punchLhit/golpe").disabled = false
#		else:
#			get_node("punchLhit/golpe").disabled = true
#	else:
#			get_node("punchLhit/golpe").disabled = true
	
	if(flippable and !objMyself.reading):
		if(objMyself.intMove == 1):
			flip_h = false;
		elif(objMyself.intMove == -1):
			flip_h = true;
	if(!objMyself.bolGround() and objMyself.velocity.y != 0):
		if(objMyself.velocity.y < -20):
			animation = jump;
		else:
			animation = fall;
			#animation = slide;
	else:
		if(objMyself.velocity.x != 0 and objMyself.bolGround()):
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

func getHurt():
	gotHurt = objMyself.invencibleMAX;
	hurtAnims();
func defaultAnims():
	idle = "idle";
	walk = "walk";
	jump = "jump";
	fall = "fall";
	flippable = true;
	isDefaultAnims = true;
	
	addCompanionPrefix()
	
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
	
	addCompanionPrefix()
	
func airPunchAnims(side):
	if(side == 0):
		idle = "punchAir";
		walk = "punchAir";
		jump = "punchAir";
		fall = "punchAir";
	flippable = false;
	frame = 0;
	isDefaultAnims = false;
	
	addCompanionPrefix()
	
func dashAnims():
	idle = "dash";
	walk = "dash";
	jump = "jump";
	fall = "fall";
	flippable = false;
	isDefaultAnims = false;
	
	addCompanionPrefix()

func hurtAnims():
	idle = "hurt";
	walk = "hurt";
	jump = "hurt";
	fall = "hurt";
	flippable = false;
	isDefaultAnims = false;
	
	addCompanionPrefix()
	
func addCompanionPrefix():
	idle = prefix + idle;
	walk = prefix + walk;
	jump = prefix + jump;
	fall = prefix + fall;
