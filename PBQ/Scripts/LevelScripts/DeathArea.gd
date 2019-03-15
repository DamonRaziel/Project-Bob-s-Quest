extends Spatial

func _ready():
	pass

#func _process(delta):
#	pass

func _on_Area_body_entered(body):
	if body.has_method("zombie_die"):
		body.zombie_die()
	if body.has_method("_player_death"):
		body._player_death()