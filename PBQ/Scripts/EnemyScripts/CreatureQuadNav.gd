extends KinematicBody

var accel 
var DEACCEL = 1.0
const ACCEL = 1.0

var MAX_ATTACK_SPEED = 0.0
var MAX_SPRINT_SPEED = 2.0
var MAX_SPEED = 3.0
var is_sprinting = false

var speed = 3.0

var hv = Vector3()

var enemy_origin
var enemy

var gravity = -9.8
var velocity = Vector3()

var zombie_damage = 40

var can_attack_timer = 0.0
var can_attack_time = 10.5
var attacking = false
var attack_timer = 0.0
var attack_time = 3.5

var current_health = 200
var max_health = 200
var health_to_recover = 5
var retreat_health = 35

var hit_sound

var chance_of_attack = 0
var chance_of_attack_blocked = 0
var enemy_fort = 5
var enemy_lightning_res = 5
var enemy_ice_res = 5
var enemy_fire_res = 500
var enemy_earth_res = 5

var target = null
var retreat_target = null

var navmesh
var navmeshpath
var path = []

var begin = Vector3()
var end = Vector3()

var waypoint_numbers_to_choose_from
var waypoint_number_chosen

var enemy_state = 0
#0 = idle, 1 = wander randomly, 2 = chase player, 3 = attack player, 4 = retreat

var dtimer
var decision

var rtimer

var enemy_waypoints

onready var track_timer = $TrackerTimer

var is_active = false

func _ready():
	enemy = get_node(".")
	get_node("AnimationTreePlayer").set_active(true)
	hit_sound = $CreatureHit
	navmesh = get_parent().get_parent()
	enemy_waypoints = navmesh.get_node("WaypointsHolder").waypoints
	waypoint_numbers_to_choose_from = navmesh.get_node("WaypointsHolder").waypoints_number
	dtimer = get_node("DecisionTimer")
	rtimer = get_node("RegenTimer")
	if is_active == true:
		track_timer.start()
		idle_for_a_moment()

func _on_TrackerTimer_timeout():
	zombie_tracker()
	track_timer.start()

func _process(delta):
	if enemy_state == 1:
		var to_walk = delta*speed
		var to_watch = Vector3(0, 1, 0)
		while(to_walk > 0 and path.size() >= 2):
			var pfrom = path[path.size() - 1]
			var pto = path[path.size() - 2]
			to_watch = (pto - pfrom).normalized()
			var d = pfrom.distance_to(pto)
			if (d <= to_walk):
				path.remove(path.size() - 1)
				to_walk -= d
			else:
				path[path.size() - 1] = pfrom.linear_interpolate(pto, to_walk/d)
				to_walk = 0
			
			var atpos = path[path.size() - 1]
			var atdir = to_watch
			atdir.y = 0
			
			var t = Transform()
			t.origin = atpos
			t=t.looking_at(atpos + atdir, Vector3(0, 1, 0))
			self.set_transform(t)
			
			if (path.size() < 2):
				path = []
				idle_for_a_moment()
	
	elif enemy_state == 2:
		var to_walk = delta*speed
		var to_watch = Vector3(0, 1, 0)
		while(to_walk > 0 and path.size() >= 2):
			var pfrom = path[path.size() - 1]
			var pto = path[path.size() - 2]
			to_watch = (pto - pfrom).normalized()
			var d = pfrom.distance_to(pto)
			if (d <= to_walk):
				path.remove(path.size() - 1)
				to_walk -= d
			else:
				path[path.size() - 1] = pfrom.linear_interpolate(pto, to_walk/d)
				to_walk = 0
			
			var atpos = path[path.size() - 1]
			var atdir = to_watch
			atdir.y = 0
			
			var t = Transform()
			t.origin = atpos
			t=t.looking_at(atpos + atdir, Vector3(0, 1, 0))
			self.set_transform(t)
			
			if (path.size() < 2):
				path = []
				calculate_path()
	
	elif enemy_state == 4:
		var to_walk = delta*speed
		var to_watch = Vector3(0, 1, 0)
		while(to_walk > 0 and path.size() >= 2):
			var pfrom = path[path.size() - 1]
			var pto = path[path.size() - 2]
			to_watch = (pto - pfrom).normalized()
			var d = pfrom.distance_to(pto)
			if (d <= to_walk):
				path.remove(path.size() - 1)
				to_walk -= d
			else:
				path[path.size() - 1] = pfrom.linear_interpolate(pto, to_walk/d)
				to_walk = 0
			
			var atpos = path[path.size() - 1]
			var atdir = to_watch
			atdir.y = 0
			
			var t = Transform()
			t.origin = atpos
			t=t.looking_at(atpos + atdir, Vector3(0, 1, 0))
			self.set_transform(t)
			
			if (path.size() < 2):
				path = []
				idle_for_a_moment()
	if enemy_state == 1:
		get_node("AnimationTreePlayer").blend2_node_set_amount("ZIdleOrMove", 1)
	if enemy_state == 2:
		get_node("AnimationTreePlayer").blend2_node_set_amount("ZIdleOrMove", 1)
	if enemy_state == 4:
		get_node("AnimationTreePlayer").blend2_node_set_amount("ZIdleOrMove", 1)

func _physics_process(delta):
	#----Enemy Movement Setion----#
	enemy_origin = enemy.get_global_transform().origin
	var offset = Vector3()
	if target != null:
		offset = target.get_global_transform().origin - enemy_origin
	else:
		offset = null
	var dir = Vector3()
	if target != null:
		dir += offset
		dir.y = 0
		dir = dir.normalized()
	else:
		dir = null
	velocity.y += delta*gravity
	var hv = velocity
	hv.y = 0
	var mtarget
	if target != null:
		mtarget = dir
	else:
		mtarget = 0
	var attacking = false
	if attacking == true:
		mtarget *= MAX_ATTACK_SPEED
	elif attacking == false:
		if is_sprinting:
			mtarget *= MAX_SPRINT_SPEED
		else:
			mtarget *= MAX_SPEED
	var ATTACK_ACCEL = 1
	var SPRINT_ACCEL = 2
	var accel
	if target != null:
		if dir.dot(hv) > 0:
			if attacking == true:
				accel = ATTACK_ACCEL
			elif attacking == false:
				if is_sprinting:
					accel = SPRINT_ACCEL
				else:
					accel = ACCEL
		else:
			accel = DEACCEL
	
		hv = hv.linear_interpolate(mtarget, accel*delta)
		velocity.x = hv.x
		velocity.z = hv.z
	#----End of Movement Section----#
	
	#----Attack Section----#
	if enemy_state == 3:
		if can_attack_timer >=can_attack_time:
			if attack_timer>=attack_time:
				velocity = move_and_slide(Vector3(0,0,0), Vector3(0,1,0))
				var angle = atan2(-hv.x, -hv.z)
				var char_rot = enemy.get_rotation()
				char_rot.y = angle
				enemy.set_rotation(char_rot)
				attacking = true
				zombie_attack()
			else:
				attacking = false
	
	if can_attack_timer<can_attack_time:
		can_attack_timer += 0.06
	if enemy_state == 3:
		if attack_timer<attack_time:
			attack_timer += 0.06
	
	if enemy_state == 3:
		get_node("AnimationTreePlayer").blend2_node_set_amount("ZIdleOrMove", 0)
		if attacking == true:
			get_node("AnimationTreePlayer").oneshot_node_start("ZOneShot")

func zombie_attack():
	var area = $Area
	var bodies = area.get_overlapping_bodies()
	var damage
	damage = zombie_damage
	for abody in bodies:
		if abody == self:
			continue
		if abody.has_method("_hit"):
			abody._hit(damage, 0, area.global_transform.origin)
	can_attack_timer = 0.0
	attack_timer = 0.0

func zombie_tracker():
	var map_area = $Map_Area
	var bodies_map = map_area.get_overlapping_bodies()
	var pos_x = self.global_transform.origin.x
	var pos_y = self.global_transform.origin.z
	for body in bodies_map:
		if body == self:
			continue
		if body.has_method("track_zombies"):
			body.track_zombies(pos_x, pos_y)

func _on_Detect_Area_body_entered(body):
	if body.has_method("process_UI"):
		if current_health >= retreat_health:
			target = body
			enemy_state = 2
			dtimer.stop()
			calculate_path()
		else:
			pick_retreat_waypoint()
			dtimer.stop()

func _on_Detect_Area_body_exited(body):
	if body.has_method("process_UI"):
		target = null
		idle_for_a_moment()

func _on_Attack_Area_body_entered(body):
	if body.has_method("process_UI"):
		enemy_state = 3
		set_physics_process(true)
		set_process(false)

func _on_Attack_Area_body_exited(body):
	if body.has_method("process_UI"):
		if current_health >= retreat_health:
			target = body
			enemy_state = 2
			calculate_path()
		else:
			pick_retreat_waypoint()

func _hit(damage, type, _hit_pos):
	randomize()
	var hit_points_lost
	if type == 0:
		hit_points_lost = damage - enemy_fort
		hit_points_lost = clamp(hit_points_lost, 0, 500)
		current_health -= hit_points_lost
	elif type == 1:
		hit_points_lost = damage - enemy_lightning_res
		hit_points_lost = clamp(hit_points_lost, 0, 500)
		current_health -= hit_points_lost
	elif type == 2:
		hit_points_lost = damage - enemy_ice_res
		hit_points_lost = clamp(hit_points_lost, 0, 500)
		current_health -= hit_points_lost

	elif type == 3:
		hit_points_lost = damage - enemy_fire_res
		hit_points_lost = clamp(hit_points_lost, 0, 500)
		current_health -= hit_points_lost
	elif type == 4:
		hit_points_lost = damage - enemy_earth_res
		hit_points_lost = clamp(hit_points_lost, 0, 500)
		current_health -= hit_points_lost
	hit_sound.play()
	chance_of_attack = randi()%100+1
	chance_of_attack_blocked = ((damage*2)-enemy_fort)
	if chance_of_attack <= chance_of_attack_blocked:
		can_attack_timer = 0.0
	PlayerData.points_add(damage)
	if current_health < retreat_health:
		pick_retreat_waypoint()
	if current_health <= 0:
		zombie_die()

func zombie_die():
	PlayerData.points_add(30)
	queue_free()

func _on_DecisionTimer_timeout():
	if is_active == true:
		randomize()
		decision = randi()%2
		if decision == 0:
			idle_for_a_moment()
		elif decision == 1:
			pick_waypoint()
	else:
		dtimer.start()
		enemy_state = 0
		set_physics_process(false)
		set_process(false)

func idle_for_a_moment():
	dtimer.start()
	enemy_state = 0
	set_physics_process(false)
	set_process(false)
	get_node("AnimationTreePlayer").blend2_node_set_amount("ZIdleOrMove", 0)

func pick_waypoint():
	randomize()
	waypoint_number_chosen = randi()%waypoint_numbers_to_choose_from
	target = enemy_waypoints[waypoint_number_chosen]
	enemy_state = 1
	calculate_path()

func pick_retreat_waypoint():
	randomize()
	waypoint_number_chosen = randi()%waypoint_numbers_to_choose_from
	target = enemy_waypoints[waypoint_number_chosen]
	enemy_state = 4
	calculate_path()

func _on_RegenTimer_timeout():
	rtimer.start()
	if current_health < max_health:
		current_health += health_to_recover
		current_health = clamp(current_health, 0, max_health)
	else:
		pass

func calculate_path():
	begin = self.global_transform.origin
	end = target.global_transform.origin
	
	var p = navmesh.get_simple_path(begin, end, true) 
	path = Array(p)
	path.invert()
	if enemy_state == 2:
		set_physics_process(false)
		set_process(true)
	elif enemy_state == 4:
		set_physics_process(false)
		set_process(true)
	elif enemy_state == 1:
		set_physics_process(false)
		set_process(true)

func _on_Map_Area_body_entered(body):
	if body.has_method("process_UI"):
		is_active = true
		track_timer.start()
		dtimer.start()
	else:
		pass

func _on_Map_Area_body_exited(body):
	if body.has_method("process_UI"):
		is_active = false
		track_timer.stop()
		dtimer.stop()
	else:
		pass
