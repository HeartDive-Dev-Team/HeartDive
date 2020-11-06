extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var sceneCurrent;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func cleanSpawnedNodes():
	for node in get_tree().get_root().get_children():
		if "enemy" in node.get_name():
			if node.spawnerGenerated == true:
				node.queue_free();

func reloadScene():
	gvar.G_preDeathRoom = get_tree().current_scene.filename;
	gvar.G_preDeathSong = MusicPlayer.musicPlaying;
	cleanSpawnedNodes()
	get_tree().reload_current_scene();
	gotoGameover();

func gotoGameover():
	get_tree().change_scene("res://Rooms/gameOver.tscn");
