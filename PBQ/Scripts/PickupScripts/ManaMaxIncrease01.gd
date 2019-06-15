extends Spatial

const MAX_MANA_INCREASE = 50

func _on_Area_body_entered(body):
	if body.has_method("increase_max_mana"):
		body.increase_max_mana(MAX_MANA_INCREASE)
		queue_free()




