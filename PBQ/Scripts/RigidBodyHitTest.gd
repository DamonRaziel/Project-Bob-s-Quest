extends RigidBody

export var impulse_amount = 0.25
export var thrown_impulse_amount = 0.25

func _ready():
	pass

#func _process(delta):
#	pass

func _hit(damage, type, _hit_pos):
	var direction_vect = global_transform.origin - _hit_pos
	direction_vect = direction_vect.normalized()
	apply_impulse(_hit_pos, direction_vect * damage)

func detect_bump():
	var bump_area = $BumpArea
	var bump_bodies = bump_area.get_overlapping_bodies()
	for bump_body in bump_bodies:
		if bump_body == self:
			continue
		if bump_body.has_method("zombie_tracker"):
			_bump(bump_area.global_transform.origin) #abody._hit(damage, 0, area.global_transform.origin)

func _bump(hit_pos):
	var direction_vect = global_transform.origin - hit_pos
	direction_vect = direction_vect.normalized()
	apply_impulse(hit_pos, direction_vect * impulse_amount)
