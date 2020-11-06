extends Node2D


# Declare member variables here. Examples:
var active = true;
var indexMenu = 0;
var phase = 0;
onready var arrow = get_node("selectionArrow");
onready var FadeOut = get_node("FadeOut");
var roomGoto = "";
var soundTest = 0;

onready var lbl_musicVol = get_node("Texts/Information/Music/lbl_musicVol");
onready var lbl_SFXVol = get_node("Texts/Information/lbl_SFXVol");
onready var lbl_Screen = get_node("Texts/Information/lbl_Screen");
onready var lbl_SoundTest = get_node("Texts/Information/lbl_SoundTest");

# Called when the node enters the scene tree for the first time.
func _ready():
	lbl_musicVol.text = convertMusicVolume(gvar.G_musicVolume);
	lbl_SFXVol.text = convertMusicVolume(gvar.G_SFXVolume);
	lbl_SoundTest.text = str(soundTest);
	gvar.HUD_OFF();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(active):
		if(phase == 0):
			lbl_Screen.modulate = Color(1,1,1);
			lbl_SFXVol.modulate = Color(1,1,1);
			lbl_musicVol.modulate = Color(1,1,1);
			lbl_SoundTest.modulate = Color(1,1,1);
			arrow.modulate = Color(1,1,1);
			if(Input.is_action_just_pressed("ui_down")):
				get_node("selectSFX").play();
				if(indexMenu < 4):
					indexMenu += 1;
				else:
					indexMenu = 0;
				
			if(Input.is_action_just_pressed("ui_up")):
				get_node("selectSFX").play();
				if(indexMenu > 0):
					indexMenu -= 1;
				else:
					indexMenu = 4;
					#Change object positions
			match indexMenu:
				0:
					arrow.position.y = 88;
				1:
					arrow.position.y = 160
				2:
					arrow.position.y = 232;
				3:
					arrow.position.y = 312;
					lbl_SoundTest.modulate = Color(1,1,0);
					if(Input.is_action_just_pressed("ui_left")):
						if(soundTest > 0):
							soundTest -= 1;
							get_node("selectSFX3").play();
					if(Input.is_action_just_pressed("ui_right")):
						if(soundTest < 9):
							soundTest += 1;
							get_node("selectSFX3").play();
					lbl_SoundTest.text = str(soundTest);
					
				4:
					arrow.position.y = 384;
			
			if(Input.is_action_just_pressed("ui_accept") and phase == 0):
				phase = 1;
				get_node("selectSFX2").play();
			if(Input.is_action_just_pressed("ui_cancel")):
					get_node("cancelSFX").play();
					FadeOut.activate();
					RoomChanger.activate("res://Rooms/menu02.tscn", 60);
					active = false;
		elif(phase == 1):
			match indexMenu:
				0: #Screen Resolution
					if(OS.window_fullscreen):
						lbl_Screen.text = "Windowed";
					else:
						lbl_Screen.text = "Fullscreen";
					OS.window_fullscreen = !OS.window_fullscreen;
					phase = 0;
					lbl_Screen.modulate = Color(0,1,1);
				1: #Music Volume
					if(Input.is_action_just_pressed("ui_left")):
						if(gvar.G_musicVolume > -60):
							gvar.G_musicVolume -= 6;
							get_node("selectSFX3").play();
					if(Input.is_action_just_pressed("ui_right")):
						if(gvar.G_musicVolume < 6):
							gvar.G_musicVolume += 6;
							get_node("selectSFX3").play();
					AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), gvar.G_musicVolume);
					lbl_musicVol.text = convertMusicVolume(gvar.G_musicVolume);
					lbl_musicVol.modulate = Color(1,1,0);
				2: #SFX Volume
					if(Input.is_action_just_pressed("ui_left")):
						if(gvar.G_SFXVolume > -60):
							gvar.G_SFXVolume -= 6;
							get_node("selectSFX3").play();
					if(Input.is_action_just_pressed("ui_right")):
						if(gvar.G_SFXVolume < 6):
							gvar.G_SFXVolume += 6;
							get_node("selectSFX3").play();
					AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), gvar.G_SFXVolume);
					lbl_SFXVol.text = convertMusicVolume(gvar.G_SFXVolume);
					lbl_SFXVol.modulate = Color(1,1,0);
				3:
					MusicPlayer.changeSong(soundTest);
					phase = 0;
				4:
					$cancelSFX.play();
					phase = 0;
			arrow.modulate = Color(1,1,0);
			if(Input.is_action_just_pressed("ui_accept")):
					get_node("selectSFX2").play();
					phase = 0;

func convertMusicVolume(volume):
	match volume:
		6:
			return "MAX";
		0:
			return "High";
		-6:
			return "Med";
		-12:
			return "Low";
		-18:
			return "Very Low";
		-60:
			return "OFF"
		_:
			return "MIN";
