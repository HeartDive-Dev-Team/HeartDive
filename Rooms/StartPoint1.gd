extends Node2D


# Declare member variables here. Examples:
onready var player = get_node("obj_Player");
onready var playerActor = get_node("playerNPC");
var scenePhase = 0;
var i = 0;
export(AudioStream) var roomSong;
export(AudioStream) var roomSong2;
onready var spawnBalls = get_node("spawnBalls");


# Called when the node enters the scene tree for the first time.
func _ready():
	player.reading = true;
	player.visible = false;
	player.get_node("Camera2D").position.x += 432;
	spawnBalls.visible = false;


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
			roomSong2.loop = false;
			MusicPlayer.changeSong(roomSong2);
			playerActor.playing = true;
			_delay(90);
		7:
			playerActor.animation = "player_2";
			_delay(90);
		8:
			playerActor.animation = "player_3";
			_delay(30);
		9:
			playerActor.visible = false;
			player.visible = true;
			player.position = playerActor.position;
			player.jump(player.JUMP_SPEED/2);
			_delay(0);
		10:
			_delay(120);
		11:
			player.reading = false;
			player.get_node("Camera2D").position = Vector2(0, 0);
			gvar.HUD_ON();

func _delay(myDelay):
	if(i < myDelay):
		i += 1;
	else:
		scenePhase += 1;
		i = 0;