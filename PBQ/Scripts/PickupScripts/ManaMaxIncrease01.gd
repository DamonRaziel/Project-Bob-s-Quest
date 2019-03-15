extends Spatial

const MAX_MANA_INCREASE = 50
var hit_something = false

func _ready():
	$Area.connect("body_entered", self, "collided")

func collided(body):
	if hit_something == false:
		if body.has_method("increase_max_mana"):
			body.increase_max_mana(MAX_MANA_INCREASE)
			hit_something = true
			queue_free()
