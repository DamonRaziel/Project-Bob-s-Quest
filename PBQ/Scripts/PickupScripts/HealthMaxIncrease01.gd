extends Spatial

const MAX_HEALTH_INCREASE = 50

func _on_Area_body_entered(body):
	if body.has_method("increase_max_health"):
		body.increase_max_health(MAX_HEALTH_INCREASE)
		queue_free()




