extends "res://Objects/CutsceneSystem.gd"


# Declare member variables here. Examples:
onready var player = get_node("obj_Player");
onready var playerActor = get_node("playerNPC");
export var roomSong = 0;
export var roomSong2 = 0;
onready var spawnBalls = get_node("spawnBalls");
onready var text = get_node("CutsceneSystem-TextHandler/CanvasLayer/textBox");
export var portraits = [];
export var voices = [];
onready var tutorialTiles = get_node("tiles-Tutorial");


# Called when the node enters the scene tree for the first time.
func _ready():
	if(gvar.G_targetSpawn != 1):
		player.reading = true;
		player.visible = false;
		player.get_node("Camera2D").position.x += 432;
		get_node("CanvasLayer/FadeIn2").visible = false;
		spawnBalls.visible = false;
		#Portrait default
		changeVoice(voices[0]);
		changePortrait(portraits[0]);
		changeName("Macrófago");
		changeAnimation("default");
		tutorialTiles.modulate.a = 0;
		gvar.HUD_OFF();
	else:
		scenePhase = 13;
		player.visible = true;
		player.reading = true;
		playerActor.visible = false;
		spawnBalls.visible = false;
		tutorialTiles.modulate.a = 0;
		get_node("CanvasLayer/FadeIn2").active = true;
		get_node("CanvasLayer/FadeIn").visible = false;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match scenePhase:
		0: #Pantalla en negro con 2 segundos de delay
			playerActor.visible = false;
			if(i >= 300):
				get_node("CanvasLayer/FadeIn").active = true;
			_delay(480);
		1: #Hacer un FadeIn
			if(player.get_node("Camera2D").position.x > 0):
				player.get_node("Camera2D").position.x -= 1;
			_delay(300);
		2:
			playerActor.visible = true;
			playerActor.animation = "default";
			playerActor.playing = true;
			MusicPlayer.changeSong(roomSong);
			spawnBalls.visible = true;
			spawnBalls.get_node("spawnBall").position.y -= 480*2;
			spawnBalls.get_node("spawnBall2").position.y += 480*2;
			spawnBalls.get_node("spawnBall3").position.x -= 480*2;
			spawnBalls.get_node("spawnBall4").position.x += 480*2;
			spawnBalls.get_node("spawnBall5").position += Vector2(480*2, 480*2);
			spawnBalls.get_node("spawnBall6").position -= Vector2(480*2, 480*2);
			_delay(0);
		3:
			spawnBalls.get_node("spawnBall").position.y += 2;
			spawnBalls.get_node("spawnBall2").position.y -= 2;
			spawnBalls.get_node("spawnBall3").position.x += 2;
			spawnBalls.get_node("spawnBall4").position.x -= 2;
			spawnBalls.get_node("spawnBall5").position -= Vector2(2, 2);
			spawnBalls.get_node("spawnBall6").position += Vector2(2, 2);
			spawnBalls.rotate(0.04)
			for i in range(0, spawnBalls.get_child_count()):
				spawnBalls.get_child(i).rotate(-0.04);
			_delay(480);
		4:
			spawnBalls.visible = false;
			playerActor.animation = "player_0";
			_delay(60);
		5:
			MusicPlayer.stopSong();
			playerActor.animation = "player_1";
			playerActor.playing = false;
			_delay(240);
		6:
			MusicPlayer.changeSong(roomSong2);
			playerActor.playing = true;
			_delay(90);
		7:
			playerActor.animation = "player_2";
			_delay(90);
		8:
			showMessage("Oye, Neutrófilo!");
			_delay(0);
		9:
			playerActor.animation = "player_3";
			_delay(30);
		10:
			playerActor.visible = false;
			player.visible = true;
			player.position = playerActor.position;
			player.jump(player.JUMP_SPEED/2);
			_delay(0);
		11:
			showMessage("El corazón está siendo atacado y necesito tu ayuda para defenderlo.");
			_delay(0);
		12:
			player.reading = false;
			player.get_node("Camera2D").position = Vector2(0, 0);
			gvar.HUD_ON();
			_delay(180);
		13:
			player.reading = false;
			gvar.HUD_ON();
			_delay(1);
		14:
			if(tutorialTiles.modulate.a < 1):
				tutorialTiles.modulate.a += 0.2;
