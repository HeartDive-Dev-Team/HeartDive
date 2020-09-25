extends Node2D


# Declare member variables here. Examples:
onready var music = get_node("AudioStreamPlayer");
var musicArray = [];


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false;
	playSong();
	musicArray.resize(99);
	musicArray[0] = preload("res://Music/HD OST - Menu.ogg");
	musicArray[1] = preload("res://Music/HD OST - Welcome.ogg");
	musicArray[2] = preload("res://Music/HD OST - Spawn_1.ogg");
	musicArray[2].loop = false;
	musicArray[3] = preload("res://Music/HD OST - Spawn_2.ogg");
	musicArray[3].loop = false;
	musicArray[4] = preload("res://Music/HD OST - macrofago 2.ogg");

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass;

func playSong():
	if(!music.playing):
		music.play();

func stopSong():
	music.stop();
	
func changeSong(songToPlay):
	if(music.stream != musicArray[songToPlay]):
		music.stream = musicArray[songToPlay];
	playSong();
