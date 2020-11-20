extends "res://Objects/CutsceneSystem.gd"


# Declare member variables here. Examples:
onready var text = get_node("CutsceneSystem-TextHandler/CanvasLayer/textBox");
var logoVelocity = Vector2(0, 0);
onready var logo = get_node("AnimatedSprite");
onready var logoText = get_node("text-TeamShark");
export var roomGoto = "";

# Called when the node enters the scene tree for the first time.
func _ready():
	gvar.HUD_OFF();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	logo.position += logoVelocity;
	logoVelocity.y += 0.5;
	if(Input.is_action_just_pressed("ui_accept")):
		scenePhase = 5;
	match(scenePhase):
		0:
			logo.visible = false;
			_delay(45);
		1:
			logo.visible = true;
			logo.position = Vector2(736, 424);
			logoVelocity.x = -7;
			logoVelocity.y = -15;
			_delay(0);
		2:
			if(logo.position.x <= 432):
				logoVelocity.x = 0;
				logoText.animation = "effect";
			if(logo.position.y >= 232 and logoVelocity.y > 0):
				logoVelocity.y = 0;
				logoText.animation = "effect";
				
			if(logoVelocity == Vector2(0, 0)):
				logoText.animation = "effect";
				_delay(0);
			_delay(120);
		3:
			get_node("he_spin").play();
			_delay(0);
		4:
			
			logoText.animation = "effect";
			logoVelocity = Vector2(0, 0);
			_delay(90);
		5:
			get_node("FadeOut").activate();
			RoomChanger.activate(roomGoto, 60);
			_delay(0);
		6:
			logoVelocity = Vector2(0, 0);
