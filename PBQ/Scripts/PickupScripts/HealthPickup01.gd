extends Spatial

const HEALTH_REGAIN = 20
var hit_something = false

func _ready():
	$Area.connect("body_entered", self, "collided")

func collided(body):
	if hit_something == false:
		if body.has_method("gain_health"):
			body.gain_health(HEALTH_REGAIN)
			hit_something = true
			queue_free()