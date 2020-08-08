extends Node2D


# Declare member variables here. Examples:
onready var music = get_node("AudioStreamPlayer");


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false;
	playSong();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass;

func playSong():
	if(!music.playing):
		music.play();

func stopSong():
	music.stop();
	
func changeSong(songToPlay : AudioStream):
	if(music.stream != songToPlay):
		music.stream = songToPlay;
	playSong();
