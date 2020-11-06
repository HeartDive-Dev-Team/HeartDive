extends "res://Objects/CutsceneSystem.gd"


# Declare member variables here. Examples:
onready var player = get_node("obj_Player");
onready var macrophage = get_node("macrofagoNPC");
onready var text = get_node("CutsceneSystem-TextHandler/CanvasLayer/textBox");
onready var cam = get_node("obj_Player/Camera2D");
export var portraits = [];
export var voices = [];
export var roomGoto = "";

# Called when the node enters the scene tree for the first time.
func _ready():
	player.reading = true;
	changePortrait(portraits[1]);
	changeVoice(voices[0]);
	changeName("Macrophage");
	gvar.HUD_OFF();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		match scenePhase:
			0:
				MusicPlayer.stopSong();
				get_node("enemy_Spawner").active = false;
				get_node("enemy_Spawner2").active = false;
				get_node("enemy_Spawner3").active = false;
				macrophage.speed.x = 1;
				_delay(60);
			1:
				macrophage.speed.x = 0;
				macrophage.get_node("AnimatedSprite").animation = "shocked";
				_delay(30);
			2:
				macrophage.flipSprite();
				_delay(0);
			3:
				changeAnimation("shocked");
				showMessage("Oh no! The situation has gotten a lot worse since I left.");
				_delay(0);
			4:
				endMessage();
				cam.offset += Vector2(4, -2);
				_delay(270);
			5:
				changeAnimation("default");
				showMessage("The inhabitants of HeartDive have fled to some other parts of the body.");
				_delay(0);
			6:
				endMessage();
				cam.offset += Vector2(1.4, -1.25);
				_delay(270);
			7:
				get_node("enemy_Spawner").active = true;
				get_node("enemy_Spawner2").active = true;
				get_node("enemy_Spawner3").active = true;
				_delay(180);
			8:
				get_node("enemy_Spawner").active = false;
				get_node("enemy_Spawner2").active = false;
				get_node("enemy_Spawner3").active = false;
				
				changeAnimation("serious");
				showMessage("Those purple things seem to be the root cause of the problem.");
				_delay(0);
			9:
				changeAnimation("default");
				showMessage("They've started to appear in different areas of the body, but I didn't think it would spread to here too.");
				_delay(0);
			10:
				showMessage("There are still a few bacteria back there, so I'll leave this task to you.");
				_delay(0);
			11:
				showMessage("Please help me destroy those things spawning from the floor and help me wipe out all bacteria around the zone.")
				_delay(0);
			12:
				endMessage();
				get_node("macrofagoNPC/AnimatedSprite").animation = "default";
				cam.offset += Vector2(-10.8, 6.5);
				_delay(135);
			13:
				showMessage("Got the plan?");
				_delay(0);
			14:
				endMessage();
				player.jump(player.JUMP_SPEED/2);
				_delay(0);
			15:
				_delay(30);
			16:
				changeAnimation("happy");
				showMessage("Good!");
				_delay(0);
			17:
				endMessage();
				macrophage.speed.x = -4;
				_delay(120);
			18:
				macrophage.speed.x = 0; #Para que no se siga moviendo al infinito
				macrophage.visible = false;
				gvar.HUD_ON();
				player.reading = false;
				get_node("enemy_Spawner").active = true;
				get_node("enemy_Spawner2").active = true;
				get_node("enemy_Spawner3").active = true;
				MusicPlayer.changeSong(1);
				_delay(0);
			19:
				var enemies = get_tree().get_nodes_in_group("enemies");
				if enemies.size() == 0:
					scenePhase += 1;
			20:
				player.reading = true;
				RoomChanger.activate(roomGoto, 60);
				get_node("CanvasLayer/FadeOut").activate();
				MusicPlayer.stopSong();
				_delay(0);
			21:
				pass;
