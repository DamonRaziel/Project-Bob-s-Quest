extends RigidBody

#const TARGET_HEALTH = 40
var current_health = 60
var broken_target_holder
#var target_collision_shape
#var target_mesh

#const TARGET_RESPAWN_TIME = 14
#var target_respawn_timer = 0
export (PackedScene) var destroyed_target
export var impulse_amount = 1.0

export var thrown_impulse_amount = 1.0
var grabbed = false
export var object_type = 1
# 1= barrel, 2 = crate, other = others added later

func _ready():
	broken_target_holder = get_parent()
#	broken_target_holder = get_parent().get_node("BrokenHolder")
#	target_collision_shape = $Collision_Shape
#	target_mesh = self

#func _process(delta):
#	pass

func _physics_process(delta):
	detect_bump()
#	if target_respawn_timer > 0:
#		target_respawn_timer -= delta
#		if target_respawn_timer <= 0:
#			for child in broken_target_holder.get_children():
#				child.queue_free()
#			target_collision_shape.disabled = false
#			target_mesh.visible = true
#			current_health = TARGET_HEALTH

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
	#		target_respawn_timer = TARGET_RESPAWN_TIME
	#		target_collision_shape.disabled = true
	#		target_mesh.visible = false

func detect_bump():
	var bump_area = $BumpArea
	var bump_bodies = bump_area.get_overlapping_bodies()
	for bump_body in bump_bodies:
		if bump_body == self:
			continue
		if bump_body.has_method("zombie_tracker"):
			print("zombie bump")
			_bump(bump_body.global_transform.origin) #abody._hit(damage, 0, area.global_transform.origin)

func _bump(hit_pos):
	var direction_vect = global_transform.origin - hit_pos
	direction_vect = direction_vect.normalized()
	apply_impulse(hit_pos, direction_vect * impulse_amount)
