extends AnimationPlayer


var objPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	objPlayer = get_parent();
	

func _process(delta):
	if objPlayer.inicioGolpeL == true:
		play ("punchL")


func _on_anim_animation_finished(anim_name):
	objPlayer.tieneControl = true
