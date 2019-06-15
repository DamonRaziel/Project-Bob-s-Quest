extends Spatial

var initial_damage = 20.0

func _process(delta):
	var scale_amount = get_node("Area").get_scale().x
	print ("flame engulf scale amount : " , scale_amount)
	var area = $Area
	var bodies = area.get_overlapping_bodies()
	var damage_float
	var damage
	damage_float = initial_damage/scale_amount
	damage = int(round(damage_float))
	for body in bodies:
		if body == self:
			continue
		if body.has_method("_hit"):
			body._hit(damage, 3, area.global_transform.origin)

func _on_Timer_timeout():
	queue_free()
