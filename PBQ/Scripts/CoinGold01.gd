extends Spatial

const COIN_WORTH = 5

func _on_Area_body_entered(body):
	if body.has_method("gain_coin"):
		body.gain_coin(COIN_WORTH)
		queue_free()




