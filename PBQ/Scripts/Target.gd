extends StaticBody

const TARGET_HEALTH = 40
var current_health = 40
var broken_target_holder
var target_collision_shape
var target_mesh

const TARGET_RESPAWN_TIME = 14
var target_respawn_timer = 0
export (PackedScene) var destroyed_target

func _ready():
	broken_target_holder = get_parent().get_node("BrokenHolder")
	target_collision_shape = $Collision_Shape
	target_mesh = self

func _physics_process(delta):
	if target_respawn_timer > 0:
		target_respawn_timer -= delta
		if target_respawn_timer <= 0:
			for child in broken_target_holder.get_children():
				child.queue_free()
			target_collision_shape.disabled = false
			target_mesh.visible = true
			current_health = TARGET_HEALTH

func _hit(damage, type, _hit_pos):
	current_health -= damage
	PlayerData.Player_Information.player_points += 10
	if current_health <= 0:
		PlayerData.Player_Information.player_points += 20
		var clone = destroyed_target.instance()
		broken_target_holder.add_child(clone)
		target_respawn_timer = TARGET_RESPAWN_TIME
		target_collision_shape.disabled = true
		target_mesh.visible = false
