extends Node2D

var lista = []
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	lista.resize(99)
	lista[0] = preload("res://Objects/Enemies/enemy1.tscn")
	lista[1] = preload("res://Objects/Enemies/flyer-enemy1.tscn")
	lista[2] = preload("res://Objects/Enemies/flyer-chaser-enemy1.tscn")

# :D

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
