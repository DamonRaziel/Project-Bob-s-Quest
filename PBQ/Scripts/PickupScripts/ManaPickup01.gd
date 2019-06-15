extends Spatial

const MANA_REGAIN = 20

func _on_Area_body_entered(body):
	if body.has_method("gain_mana"):
		body.gain_mana(MANA_REGAIN)
		queue_free()




