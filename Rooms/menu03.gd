extends Node2D


# Declare member variables here. Examples:
onready var square = get_node("SelectionSquare");
var phase = 0;
var cardIndex = 0;
var optionIndex = 0;
onready var descripciones = get_node("Texts/Descriptions");
onready var fadeOut = get_node("FadeOut");
export var roomGoto = "";

# Called when the node enters the scene tree for the first time.
func _ready():
	square.position.y = 100;
	matchCardIndex();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Phase 0: Select the Save File
	match phase:
		0:
			if(Input.is_action_just_pressed("ui_right")):
				if(cardIndex < 2):
					cardIndex += 1;
				else:
					cardIndex = 0;
				matchCardIndex();
				get_node("selectSFX").play();
			if(Input.is_action_just_pressed("ui_left")):
				if(cardIndex > 0):
					cardIndex -= 1;
				else:
					cardIndex = 2;
				matchCardIndex();
				get_node("selectSFX").play();
			if(Input.is_action_just_pressed("keyZ") or Input.is_action_just_pressed("ui_accept")):
				phase = 1;
				descripciones.get_child(cardIndex).text = "Do you want to start a new File?"
				get_node("Texts/Label").text = "Press Enter to confirm";
				get_node("selectSFX2").play();
			if(Input.is_action_just_pressed("ui_cancel")):
				get_node("cancelSFX").play();
				fadeOut.activate();
				roomGoto = "res://Rooms/menu02.tscn";
				RoomChanger.activate(roomGoto, 60);
				phase = -1;
		#Phase 1: Load or Edit
		1:
			if(Input.is_action_just_pressed("ui_cancel") or Input.is_action_just_pressed("keyA")):
				descripciones.get_child(cardIndex).text = "Empty";
				get_node("Texts/Label").text = "Select your Save File";
				get_node("cancelSFX").play();
				phase = 0;
			if(Input.is_action_just_pressed("ui_accept")):
				fadeOut.activate();
				RoomChanger.activate(roomGoto, 180);
				MusicPlayer.stopSong();
				get_node("selectSFX2").play();
				phase = -1;
func matchCardIndex():
	match cardIndex:
		0:
			square.position.x = 152;
		1:
			square.position.x = 432;
		2:
			square.position.x = 712;
