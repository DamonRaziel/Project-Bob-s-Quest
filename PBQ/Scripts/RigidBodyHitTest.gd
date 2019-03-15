extends RigidBody

func _ready():
	pass

#func _process(delta):
#	pass

func _hit(damage, _hit_pos):
	var direction_vect = global_transform.origin - _hit_pos
	direction_vect = direction_vect.normalized()
	apply_impulse(_hit_pos, direction_vect * damage)
