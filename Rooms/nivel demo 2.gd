extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(AudioStream) var songToPlay;


# Called when the node enters the scene tree for the first time.
func _ready():
	MusicPlayer.changeSong(songToPlay);


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass