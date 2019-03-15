extends Spatial

const MANA_REGAIN = 20
var hit_something = false

func _ready():
	$Area.connect("body_entered", self, "collided")

func collided(body):
	if hit_something == false:
		if body.has_method("gain_mana"):
			body.gain_mana(MANA_REGAIN)
			hit_something = true
			queue_free()
