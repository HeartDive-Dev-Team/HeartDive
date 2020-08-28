extends AnimatedSprite

var objPlayer;

var idle = "idle";
var walk = "walk";
var jump = "jump";
var fall = "fall";
var slide = "slide";
var flippable = true;
var gotHurt = -1;

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
		#Transparency effect
		if(gotHurt % 2 == 0):
			modulate.a = 0.1;
		else:
			modulate.a = 1;
	elif(gotHurt == 0):
		modulate.a = 1;
		gotHurt = -1;
func getHurt():
	gotHurt = objPlayer.invencibleMAX;
func defaultAnims():
	idle = "idle";
	walk = "walk";
	jump = "jump";
	fall = "fall";
	slide = "slide";
	flippable = true;
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
func airPunchAnims(side):
	if(side == 0):
		idle = "punchAir";
		walk = "punchAir";
		jump = "punchAir";
		fall = "punchAir";
	flippable = false;
	frame = 0;
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
func dashAnims():
	idle = "dash";
	walk = "dash";
	jump = "jump";
	fall = "fall";
	flippable = false;
