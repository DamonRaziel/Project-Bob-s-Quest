extends KinematicBody

var accel 
var DEACCEL = 1.0
const ACCEL = 1.0

var MAX_ATTACK_SPEED = 0.0
var MAX_SPRINT_SPEED = 2.0
var MAX_SPEED = 2.5
var is_sprinting = false

var speed = 2.5

var hv = Vector3()

var enemy_origin
var enemy

var gravity = -9.8
var velocity = Vector3()

var zombie_damage = 30

var can_attack_timer = 0.0
var can_attack_time = 10.5
var attacking = false
var attack_timer = 0.0
var attack_time = 3.5
var attack = 1

var current_health = 100
var max_health = 100
var health_to_recover = 5
var retreat_health = 20

var hit_sound

var chance_of_attack = 0
var chance_of_attack_blocked = 0
var enemy_fort = 5
var enemy_lightning_res = 5
var enemy_ice_res = 5
var enemy_fire_res = 5
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

var attack_timer1
var attack_timer2
var attack_timer3
var attack_timer4
var attack_timer5

var attack_ind1
var attack_ind2
var attack_ind3

var attack_point1
var attack_point2
var attack_point3
var attack_point4
var attack_point5
var attack_point6
var attack_point7
var attack_point8
var attack_point9
var attack_point10
var attack_point11
var attack_point12

var chance_of_attack_on_retreat
var chance_of_attack_on_death

var flight_height = 3.0
var max_flight_height = 5.0
var max_max_flight_height = 5.0
var flight_height_speed = 0.25
var min_flight_height = 1.75

var front_ray
var top_ray
var ascend_timer
var descend = false
var ascend = false

var main_mover_node
var armature_node
var audio_node
var attack_holder_node

var front_ray_collider
var top_ray_collider

onready var track_timer = $TrackerTimer

var is_active = false

onready var s_timer = get_node("Scan_Timer")
onready var s_timer2 = get_node("Scan_Timer2")

func _ready():
	enemy = get_node(".")
	hit_sound = $AudioHit
	navmesh = get_parent().get_parent()
	enemy_waypoints = navmesh.get_node("WaypointsHolder").waypoints
	waypoint_numbers_to_choose_from = navmesh.get_node("WaypointsHolder").waypoints_number# - 1
	dtimer = get_node("DecisionTimer")
	rtimer = get_node("RegenTimer")
	main_mover_node = get_node("CollisionShape")
	armature_node = get_node("CreatureFlyingArmature")
	audio_node = get_node("AudioHit")
	attack_holder_node = get_node("AttackHolder")
	
	attack_timer1 = get_node("AttackTimer1")
	attack_timer2 = get_node("AttackTimer2")
	attack_timer3 = get_node("AttackTimer3")
	attack_timer4 = get_node("AttackTimer4")
	attack_timer5 = get_node("AttackTimer5")
	
	attack_ind1 = get_node("AttackHolder/AttackIndicator1")
	attack_ind2 = get_node("AttackHolder/AttackIndicator2")
	attack_ind3 = get_node("AttackHolder/AttackIndicator3")
	
	attack_point1 = get_node("AttackHolder/AttackPoint1")
	attack_point2 = get_node("AttackHolder/AttackPoint2")
	attack_point3 = get_node("AttackHolder/AttackPoint3")
	attack_point4 = get_node("AttackHolder/AttackPoint4")
	attack_point5 = get_node("AttackHolder/AttackPoint5")
	attack_point6 = get_node("AttackHolder/AttackPoint6")
	attack_point7 = get_node("AttackHolder/AttackPoint7")
	attack_point8 = get_node("AttackHolder/AttackPoint8")
	attack_point9 = get_node("AttackHolder/AttackPoint9")
	attack_point10 = get_node("AttackHolder/AttackPoint10")
	attack_point11 = get_node("AttackHolder/AttackPoint11")
	attack_point12 = get_node("AttackHolder/AttackPoint12")
	
	attack_ind1.hide()
	attack_ind2.hide()
	attack_ind3.hide()
	
	front_ray = get_node("CollisionShape/FrontRay")
	top_ray = get_node("CollisionShape/TopRay")
	ascend_timer = get_node("CollisionShape/AscendTimer")
	
	if is_active == true:
		track_timer.start()
		idle_for_a_moment()

func _on_TrackerTimer_timeout():
	zombie_tracker()
	track_timer.start()

func _process(delta):
	if front_ray.is_colliding():
		front_ray_collider = front_ray.get_collider()
		if front_ray_collider.has_method("process_UI"):
			pass
		else:
			descend = true
			ascend = false
			ascend_timer.start()
	
	if top_ray.is_colliding():
		top_ray_collider = top_ray.get_collider()
		if top_ray_collider.has_method("process_UI"):
			pass
		else:
			descend = true
			ascend = false
			ascend_timer.start()
	
	if descend == true:
		if main_mover_node.global_transform.origin.y > min_flight_height:
			main_mover_node.global_transform.origin.y -= flight_height_speed
			armature_node.global_transform.origin.y -= flight_height_speed
			audio_node.global_transform.origin.y -= flight_height_speed
			attack_holder_node.global_transform.origin.y -= flight_height_speed
	if ascend == true:
		if main_mover_node.global_transform.origin.y < max_flight_height:
			main_mover_node.global_transform.origin.y += flight_height_speed
			armature_node.global_transform.origin.y += flight_height_speed
			audio_node.global_transform.origin.y += flight_height_speed
			attack_holder_node.global_transform.origin.y += flight_height_speed
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
				start_rescan() #calculate_path()
	
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
	

#func _physics_process(delta):
	#----Enemy Movement Setion----#
	if front_ray.is_colliding():
		front_ray_collider = front_ray.get_collider()
		if front_ray_collider.has_method("process_UI"):
			pass
		else:
			descend = true
			ascend = false
			ascend_timer.start()
	
	if top_ray.is_colliding():
		top_ray_collider = top_ray.get_collider()
		if top_ray_collider.has_method("process_UI"):
			pass
		else:
			descend = true
			ascend = false
			ascend_timer.start()
	
	if descend == true:
		if main_mover_node.global_transform.origin.y > min_flight_height:
			main_mover_node.global_transform.origin.y -= flight_height_speed
			armature_node.global_transform.origin.y -= flight_height_speed
			audio_node.global_transform.origin.y -= flight_height_speed
			attack_holder_node.global_transform.origin.y -= flight_height_speed
	if ascend == true:
		if main_mover_node.global_transform.origin.y < max_flight_height:
			main_mover_node.global_transform.origin.y += flight_height_speed
			armature_node.global_transform.origin.y += flight_height_speed
			audio_node.global_transform.origin.y += flight_height_speed
			attack_holder_node.global_transform.origin.y += flight_height_speed
	
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
				randomize()
				attack = randi()%3+1
				velocity = move_and_slide(Vector3(0,0,0), Vector3(0,1,0))
				var angle = atan2(-hv.x, -hv.z)
				var char_rot = enemy.get_rotation()
				char_rot.y = angle
				enemy.set_rotation(char_rot)
				attacking = true
				if attack == 1:
					creature_attack1()
				elif attack == 2:
					creature_attack2()
				elif attack == 3:
					creature_attack3()
			else:
				attacking = false
	
	if can_attack_timer<can_attack_time:
		can_attack_timer += 0.06
	if enemy_state == 3:
		if attack_timer<attack_time:
			attack_timer += 0.06

func creature_attack1():
	attack_timer1.start()
	attack_timer2.start()
	attack_timer3.start()
	attack_ind1.show()
	can_attack_timer = 0.0
	attack_timer = 0.0

func creature_attack2():
	attack_timer1.start()
	attack_timer2.start()
	attack_timer4.start()
	attack_ind1.show()
	can_attack_timer = 0.0
	attack_timer = 0.0

func creature_attack3():
	attack_timer1.start()
	attack_timer2.start()
	attack_timer5.start()
	attack_ind1.show()
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
			attack_point1.track_target = body
			attack_point1.track_player = true
			attack_point2.track_target = body
			attack_point2.track_player = true
			enemy_state = 2
			dtimer.stop()
			calculate_path()
		else:
			pick_retreat_waypoint()
			dtimer.stop()

func _on_Detect_Area_body_exited(body):
	if body.has_method("process_UI"):
		target = null
		attack_point1.track_target = null
		attack_point1.track_player = false
		attack_point2.track_target = null
		attack_point2.track_player = false
		idle_for_a_moment()

func _on_Attack_Area_body_entered(body):
	if body.has_method("process_UI"):
		enemy_state = 3
		set_process(true)

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
	randomize()
	chance_of_attack_on_death = randi()%100
	if chance_of_attack_on_death <= 20:
		_on_AttackTimer5_timeout()
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
	set_process(false)

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
	chance_of_attack_on_retreat = randi()%100
	if chance_of_attack_on_retreat <= 20:
		_on_AttackTimer5_timeout()

func _on_RegenTimer_timeout():
	rtimer.start()
	if current_health < max_health:
		current_health += health_to_recover
		current_health = clamp(current_health, 0, max_health)
	else:
		pass

func calculate_path():
	begin = navmesh.get_closest_point(self.get_translation())
	end = navmesh.get_closest_point(target.get_translation())
	
	var p = navmesh.get_simple_path(begin, end, true) 
	path = Array(p)
	path.invert()
	set_process(true)

func _on_AttackTimer1_timeout():
	attack_ind2.show()

func _on_AttackTimer2_timeout():
	attack_ind3.show()

func _on_AttackTimer3_timeout():
	attack_ind1.hide()
	attack_ind2.hide()
	attack_ind3.hide()
	#launch attack
	attack_point1.attack()

func _on_AttackTimer4_timeout():
	attack_ind1.hide()
	attack_ind2.hide()
	attack_ind3.hide()
	#launch attack
	attack_point2.attack()

func _on_AttackTimer5_timeout():
	attack_ind1.hide()
	attack_ind2.hide()
	attack_ind3.hide()
	#launch attack
	attack_point3.attack()
	attack_point4.attack()
	attack_point5.attack()
	attack_point6.attack()
	attack_point7.attack()
	attack_point8.attack()
	attack_point9.attack()
	attack_point10.attack()
	attack_point11.attack()
	attack_point12.attack()

func _on_AscendTimer_timeout():
	descend = false
	ascend = true

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

func start_rescan():
	set_process(false)
	s_timer.start()

func rescan_for_target():
	var scan_area = $Detect_Area
	var scan_bodies = scan_area.get_overlapping_bodies()
#	var damage
#	damage = zombie_damage
	for scan_body in scan_bodies:
		if scan_body == self:
			continue
		if scan_body.has_method("process_UI"): #_hit"):
#			print ("viable body")
			calculate_path()
#			scan_body._hit(damage, 0, scan_area.global_transform.origin)
#	can_attack_timer = 0.0
#	attack_timer = 0.0

func _on_Scan_Timer_timeout():
	rescan_for_target()

func _on_Scan_Timer2_timeout():
	rescan_for_target()
	s_timer2.start()
