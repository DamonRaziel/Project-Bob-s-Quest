extends Spatial

const COIN_WORTH = 5
var hit_something = false

func _ready():
	$Area.connect("body_entered", self, "collided")

func collided(body):
	if hit_something == false:
		if body.has_method("gain_coin"):
			body.gain_coin(COIN_WORTH)
			hit_something = true
			queue_free()