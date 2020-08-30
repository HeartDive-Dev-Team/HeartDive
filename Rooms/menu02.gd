extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var active = true;
export(AudioStream) var roomSong;
var indexMenu = 0;
onready var square = get_node("SelectSquare");
onready var FadeOut = get_node("FadeOut");
var roomGoto = "";

# Called when the node enters the scene tree for the first time.
func _ready():
	MusicPlayer.changeSong(roomSong);
	#Remove this later----------------
	gvar.HUD_OFF();
	#------------------------


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(active):
		if(Input.is_action_just_pressed("ui_down")):
			get_node("selectSFX").play();
			if(indexMenu < 3):
				indexMenu += 1;
			else:
				indexMenu = 0;
			
		if(Input.is_action_just_pressed("ui_up")):
			get_node("selectSFX").play();
			if(indexMenu > 0):
				indexMenu -= 1;
			else:
				indexMenu = 3;
		
		#Change object positions
		match indexMenu:
			0:
				square.changeIndex(72);
				get_node("description").text = "Main Story of the game";
			1:
				square.changeIndex(144);
				get_node("description").text = "General configuration of the game and Sound Test (Not available yet)";
			2:
				square.changeIndex(208);
				get_node("description").text = "Extra content not featured in the Main Plot (Not available yet)";
			3:
				square.changeIndex(280);
				get_node("description").text = "Return to the Title Screen";
	#Selection
	if(Input.is_action_just_pressed("ui_accept") and active):
			#Select the room to go depending on the menu index	
			match indexMenu:
				0:
					roomGoto = "res://Rooms/menu03.tscn";
				1:
					roomGoto = "res://Rooms/menu04.tscn";
				2:
					roomGoto = "res://Rooms/menu03.tscn";
				3:
					roomGoto = "res://Rooms/menu01.tscn";
			if(indexMenu != 2 and indexMenu != 1):
				get_node("selectSFX2").play();
				RoomChanger.activate(roomGoto, 60);
				FadeOut.activate();
				active = false;
			else:
				get_node("errorSFX").play();
