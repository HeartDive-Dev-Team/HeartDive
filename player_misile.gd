extends Node2D
var damageDealer = 50
var velocity = Vector2()


func _ready():
	pass


#Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocity



func _on_Area2D_area_entered(area):
	if ("enemy" in area.get_parent().get_name() and "hurtBox" in area.get_name()):
		if(position.x > area.get_parent().position.x):
			area.get_parent().takeDamage(damageDealer, -10);
		else:
			area.get_parent().takeDamage(damageDealer, 10);
	if !("Player" in area.get_parent().get_name()):
		queue_free()



func _on_Area2D_body_entered(body):
	if body is TileMap:
		queue_free()
