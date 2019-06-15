extends RigidBody

var current_health = 40
var broken_target_holder

export (PackedScene) var destroyed_target
export var impulse_amount = 1.0

export var thrown_impulse_amount = 1.0
var grabbed = false
export var object_type = 1
# 1= barrel, 2 = crate, other = others added later

func _ready():
	broken_target_holder = get_parent()

func _hit(damage, type, _hit_pos):
	if grabbed == false:
		current_health -= damage
		PlayerData.Player_Information.player_points += 10
		var direction_vect = global_transform.origin - _hit_pos
		direction_vect = direction_vect.normalized()
		apply_impulse(_hit_pos, direction_vect * impulse_amount) #damage)
		if current_health <= 0:
			PlayerData.Player_Information.player_points += 20
			var clone = destroyed_target.instance()
			broken_target_holder.add_child(clone)
			clone.global_transform = self.global_transform
			queue_free()

func _bump(hit_pos):
	var direction_vect = global_transform.origin - hit_pos
	direction_vect = direction_vect.normalized()
	apply_impulse(hit_pos, direction_vect * impulse_amount)

func _on_BumpArea_body_entered(bump_body):
	if bump_body.has_method("zombie_tracker"):
#		print("zombie bump")
		_bump(bump_body.global_transform.origin)
