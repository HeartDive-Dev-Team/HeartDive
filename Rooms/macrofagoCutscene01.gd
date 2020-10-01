extends "res://Objects/CutsceneSystem.gd"


# Declare member variables here. Examples:
onready var player = get_node("obj_Player");
onready var macrophage = get_node("macrofagoNPC");
onready var text = get_node("CutsceneSystem-TextHandler/CanvasLayer/textBox");
export var portraits = [];
export var voices = [];

# Called when the node enters the scene tree for the first time.
func _ready():
	player.reading = true;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match scenePhase:
		0:
			changeVoice(voices[0]);
			changePortrait(portraits[1]);
			changeName("???");
			changeAnimation("default");
			gvar.HUD_OFF();
			MusicPlayer.stopSong();
			_delay(100);
		1:
			showMessage("Oh wow, that was an amazing display of strength! I have to say I'm very impressed!")
			_delay(0);
		2:
			endMessage();
			player.myAnims.flip_h = true;
			_delay(30);
		3:
			_delay(1);
		4:
			player.get_node("Camera2D").offset.x -= 0.5;
			_delay(120);
		5:
			player.get_node("Camera2D").offset.x -= 0.25;
			macrophage.speed = Vector2(2, 0);
			_delay(80);
		6:
			macrophage.speed = Vector2(1, 0);
			_delay(60);
		7:
			macrophage.speed = Vector2(0, 0);
			_delay(15);
		8:
			changePortrait(portraits[0]);
			MusicPlayer.changeSong(4);
			_delay(1);
		9:
			changeAnimation("happy2");
			macrophage.get_node("AnimatedSprite").animation = "happy";
			_delay(0);
		10:
			showMessage("Ehem, allow me to introduce myself!");
			_delay(0);
		11:
			changeName("Macrophage");
			changeAnimation("default");
			showMessage("I am a macrophage, and just like you, my task is to protect The Circulatory System.");
			_delay(0);
		12:
			changeAnimation("confused");
			macrophage.get_node("AnimatedSprite").animation = "default";
			showMessage("You must be a Neutrophil, aren't you? Only one of your kind would have such a fast-paced combat style.");
			_delay(0);
		13:
			changeAnimation("default");
			showMessage("So, tell me something... are you on a mission of your own at the moment?");
			_delay(0);
		14:
			changeAnimation("confused");
			showMessage("Or are you... lost?");
			_delay(0);
		15:
			endMessage();
			_delay(120);
		16:
			showMessage("Uh... you're not a very talkative cell, are you?");
			_delay(0);
		17:
			changeAnimation("happy2");
			macrophage.get_node("AnimatedSprite").animation = "happy";
			showMessage("Well, judging by the look on your face I'll take that as a no, haha!");
			_delay(0);
		18:
			changeAnimation("default");
			macrophage.get_node("AnimatedSprite").animation = "default";
			showMessage("Look, I'll tell you about my situation.");
			_delay(0);
		19:
			showMessage("I've been given a small mission in the Main City, and even though I thought it would be easy...");
			_delay(0);
		20:
			changeAnimation("serious");
			showMessage("To be honest, I'm having more trouble than I thought!");
			_delay(0);
		21:
			changeAnimation("default");
			showMessage("There's a bunch of bacteria rioting around the city, and I could really use some help right now.");
			_delay(0);
		22:
			changeAnimation("happy2");
			macrophage.get_node("AnimatedSprite").animation = "happy";
			showMessage("And honestly, I don't remember when it was the last time I've seen someone fight like that!");
			_delay(0);
		23:
			changeAnimation("happy");
			showMessage("Ah, the thrill of a battle, do you enjoy it as much as I do?");
			_delay(0);
		24:
			changeAnimation("default");
			macrophage.get_node("AnimatedSprite").animation = "default";
			showMessage("Also, it's worth mentioning I'll give you a part of my pay if you accept to help me out, of course!");
			_delay(0);
		25:
			changeAnimation("confused");
			showMessage("Well, what do you say? Do we have a deal?");
			_delay(0);
		26:
			endMessage();
			_delay(10);
		27:
			player.jump(player.JUMP_SPEED/2);
			_delay(0);
		28:
			_delay(30);
		29:
			player.jump(player.JUMP_SPEED/2);
			_delay(0);
		30:
			_delay(60);
		31:
			changeAnimation("happy");
			macrophage.get_node("AnimatedSprite").animation = "happy";
			showMessage("Guess I'll take that as a yes!");
			_delay(0);
		32:
			changeAnimation("default");
			macrophage.get_node("AnimatedSprite").animation = "default";
			showMessage("Follow me, swift one, I'll lead the way to the city!");
			_delay(0);
		33:
			endMessage();
			if(player.get_node("Camera2D").offset.x < 0):
				player.get_node("Camera2D").offset.x += 0.25;
			macrophage.speed = Vector2(3, 0);
			_delay(30);
		34:
			if(player.get_node("Camera2D").offset.x < 0):
				player.get_node("Camera2D").offset.x += 0.5;
			player.myAnims.flip_h = false;
			_delay(180);
		35:
			if(player.get_node("Camera2D").offset.x < 0):
				player.get_node("Camera2D").offset.x += 0.5;
			player.reading = false;
			_delay(0);
