extends Spatial

const HEALTH_REGAIN = 20

func _on_Area_body_entered(body):
	if body.has_method("gain_health"):
		body.gain_health(HEALTH_REGAIN)
		queue_free()




