extends Control


func pauseGame():
	if Input.is_action_just_pressed("ui_cancel") and !get_parent().get_parent().reading:
		get_tree().paused = not get_tree().paused
	if get_tree().paused:
		get_node("blackOverlay").visible = true
	else:
		get_node("blackOverlay").visible = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pauseGame()
	
