extends KinematicBody

onready var interaction_zone = $InteractionArea
onready var level_text = get_parent().get_parent().get_parent().get_node("LevelText")
var player_is_near = false
var talking_to_player = false
onready var track_timer = $AllyTrackerTimer

#adapted from davey jones script

var accel 
var DEACCEL = 1.0
const ACCEL = 1.0

var MAX_ATTACK_SPEED = 0.0
var MAX_SPRINT_SPEED = 2.0
var MAX_SPEED = 2.5
var is_sprinting = false

var speed = 2.5

var hv = Vector3()

var ally_origin
var ally

var gravity = -9.8
var velocity = Vector3()

var ally_damage = 45

var can_attack_timer = 0.0
var can_attack_time = 10.5
var attacking = false
var attack_timer = 0.0
var attack_time = 3.5
var attack = 1

var current_health = 300
var max_health = 300
var health_to_recover = 10
var retreat_health = 35

#var hit_sound

var chance_of_attack = 0
var chance_of_attack_blocked = 0
var ally_fort = 5
var ally_lightning_res = 5
var ally_ice_res = 5
var ally_fire_res = 5
var ally_earth_res = 5

var target = null
var retreat_target = null

var navmesh
var navmeshpath
var path = []

var begin = Vector3()
var end = Vector3()

var waypoint_numbers_to_choose_from
var waypoint_number_chosen

var ally_state = 0
#0 = idle, 1 = wander randomly, 2 = chase enemy, 3 = attack enemy, 4 = retreat, 5 = go to player, 6 = near idle

var dtimer
var decision

#var rtimer

var ally_waypoints

var is_active = false

var prev_target
#var player_target
#onready var reset_areas_timer = get_node("RestoreAreasTimer")
#onready var att_area = get_node("AttackArea")
#onready var int_area = get_node("InteractionArea")
#onready var det_area = get_node("DetectArea")

func _ready():
	ally = get_node(".")
	get_node("AnimationTreePlayer").set_active(true)
#	hit_sound = $DJHit
	navmesh = get_parent().get_parent()
	ally_waypoints = navmesh.get_node("WaypointsHolder").waypoints
	waypoint_numbers_to_choose_from = navmesh.get_node("WaypointsHolder").waypoints_number
	dtimer = get_node("DecisionTimer")
#	reset_areas_timer = get_node("RestoreAreasTimer")
#	att_area = get_node("AttackArea")
#	int_area = get_node("InteractionArea")
#	det_area = get_node("DetectArea")
#	rtimer = get_node("RegenTimer")
	if is_active == true:
		track_timer.start()
		idle_for_a_moment()

func _input(event):
	if player_is_near == true:
		if(Input.is_action_just_pressed("interaction_button")):
			if talking_to_player == false:
				print ("talking to town guard 1")
				talking_to_player = true
				level_text.text = "Someone needs to beat the big zombie. /T-cont."
#				prev_target = target
#				target = player_target
				calculate_path()
#				ally_state = 5
				if PlayerData.Player_Information.spoken_to_guard01 == false:
					PlayerData.Player_Information.spoken_to_guard01 = true
			elif talking_to_player == true:
				print ("stopping talking to town guard 1")
				talking_to_player = false
				level_text.text = "T - Talk to Town Guard"
#				target = prev_target
#				prev_target = null
				idle_for_a_moment()

func _process(delta):
#	if player_is_near == true:
#		if(Input.is_action_just_pressed("interaction_button")):
#			talking_to_player = true
#			PlayerData.Player_Information.spoken_to_guard01 = true
#		if talking_to_player == false:
#			level_text.text = "T - Talk to Town Guard"
#		elif talking_to_player == true:
#			level_text.text = "Someone needs to beat the big zombie. /T-cont."
	if player_is_near == true:
#		if(Input.is_action_just_pressed("interaction_button")):
#			if talking_to_player == false:
#				talking_to_player = true
#				prev_target = target
#				target = player_target
#				calculate_path()
#				ally_state = 5
#				if PlayerData.Player_Information.spoken_to_guard01 == false:
#					PlayerData.Player_Information.spoken_to_guard01 = true
#			elif talking_to_player == true:
#				talking_to_player = false
#				target = prev_target
#				prev_target = null
#				idle_for_a_moment()
#			prev_target = target
#			target = player_target
#			PlayerData.Player_Information.spoken_to_guard01 = true
		if talking_to_player == false:
			level_text.text = "T - Talk to Town Guard"
		elif talking_to_player == true:
			level_text.text = "Someone needs to beat the big zombie. /T-cont."
	
	
	if ally_state == 1:
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
	
	elif ally_state == 2:
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
				call_deferred("calculate_path")
	
	elif ally_state == 4:
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
	
	elif ally_state == 5:
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
	
	if ally_state == 1:
		get_node("AnimationTreePlayer").blend2_node_set_amount("IdleOrMove", 1)
	if ally_state == 2:
		get_node("AnimationTreePlayer").blend2_node_set_amount("IdleOrMove", 1)
	if ally_state == 4:
		get_node("AnimationTreePlayer").blend2_node_set_amount("IdleOrMove", 1)
	if ally_state == 5:
		get_node("AnimationTreePlayer").blend2_node_set_amount("IdleOrMove", 1)

func _on_InteractionArea_body_entered(body):
	if body.has_method("process_UI"):
		player_is_near = true
#		player_target = body
	if talking_to_player == false:
		level_text.text = "T - Talk to Town Guard"
	elif talking_to_player == true:
		level_text.text = "Someone needs to beat the big zombie. /T-cont."

func _on_InteractionArea_body_exited(body):
	if body.has_method("process_UI"):
		player_is_near = false
		level_text.text = ""
#		player_target = null

func ally_tracker():
	var map_area = $Map_Area
	var bodies_map = map_area.get_overlapping_bodies()
	var pos_x = self.global_transform.origin.x
	var pos_y = self.global_transform.origin.z
	for body in bodies_map:
		if body == self:
			continue
		if body.has_method("track_allies"):
			body.track_allies(pos_x, pos_y)

func _on_AllyTrackerTimer_timeout():
	ally_tracker()
	track_timer.start()





#func _process2(delta):
#	if ally_state == 1:
#		var to_walk = delta*speed
#		var to_watch = Vector3(0, 1, 0)
#		while(to_walk > 0 and path.size() >= 2):
#			var pfrom = path[path.size() - 1]
#			var pto = path[path.size() - 2]
#			to_watch = (pto - pfrom).normalized()
#			var d = pfrom.distance_to(pto)
#			if (d <= to_walk):
#				path.remove(path.size() - 1)
#				to_walk -= d
#			else:
#				path[path.size() - 1] = pfrom.linear_interpolate(pto, to_walk/d)
#				to_walk = 0
#
#			var atpos = path[path.size() - 1]
#			var atdir = to_watch
#			atdir.y = 0
#
#			var t = Transform()
#			t.origin = atpos
#			t=t.looking_at(atpos + atdir, Vector3(0, 1, 0))
#			self.set_transform(t)
#
#			if (path.size() < 2):
#				path = []
#				idle_for_a_moment()
#
#	elif ally_state == 2:
#		var to_walk = delta*speed
#		var to_watch = Vector3(0, 1, 0)
#		while(to_walk > 0 and path.size() >= 2):
#			var pfrom = path[path.size() - 1]
#			var pto = path[path.size() - 2]
#			to_watch = (pto - pfrom).normalized()
#			var d = pfrom.distance_to(pto)
#			if (d <= to_walk):
#				path.remove(path.size() - 1)
#				to_walk -= d
#			else:
#				path[path.size() - 1] = pfrom.linear_interpolate(pto, to_walk/d)
#				to_walk = 0
#
#			var atpos = path[path.size() - 1]
#			var atdir = to_watch
#			atdir.y = 0
#
#			var t = Transform()
#			t.origin = atpos
#			t=t.looking_at(atpos + atdir, Vector3(0, 1, 0))
#			self.set_transform(t)
#
#			if (path.size() < 2):
#				path = []
#				calculate_path()
#
#	elif ally_state == 4:
#		var to_walk = delta*speed
#		var to_watch = Vector3(0, 1, 0)
#		while(to_walk > 0 and path.size() >= 2):
#			var pfrom = path[path.size() - 1]
#			var pto = path[path.size() - 2]
#			to_watch = (pto - pfrom).normalized()
#			var d = pfrom.distance_to(pto)
#			if (d <= to_walk):
#				path.remove(path.size() - 1)
#				to_walk -= d
#			else:
#				path[path.size() - 1] = pfrom.linear_interpolate(pto, to_walk/d)
#				to_walk = 0
#
#			var atpos = path[path.size() - 1]
#			var atdir = to_watch
#			atdir.y = 0
#
#			var t = Transform()
#			t.origin = atpos
#			t=t.looking_at(atpos + atdir, Vector3(0, 1, 0))
#			self.set_transform(t)
#
#			if (path.size() < 2):
#				path = []
#				idle_for_a_moment()
#	if ally_state == 1:
#		get_node("AnimationTreePlayer").blend2_node_set_amount("ZIdleOrMove", 1)
#	if ally_state == 2:
#		get_node("AnimationTreePlayer").blend2_node_set_amount("ZIdleOrMove", 1)
#	if ally_state == 4:
#		get_node("AnimationTreePlayer").blend2_node_set_amount("ZIdleOrMove", 1)

func _physics_process(delta):
#	if player_is_near == true:
#		if(Input.is_action_just_pressed("interaction_button")):
#			if talking_to_player == false:
#				talking_to_player = true
#				prev_target = target
#				target = player_target
#				if PlayerData.Player_Information.spoken_to_guard01 == false:
#					PlayerData.Player_Information.spoken_to_guard01 = true
#			elif talking_to_player == true:
#				talking_to_player = false
#				target = prev_target
#				prev_target = null
##			prev_target = target
##			target = player_target
##			PlayerData.Player_Information.spoken_to_guard01 = true
#		if talking_to_player == false:
#			level_text.text = "T - Talk to Town Guard"
#		elif talking_to_player == true:
#			level_text.text = "Someone needs to beat the big zombie. /T-cont."
	
	if player_is_near == true:
#		if(Input.is_action_just_pressed("interaction_button")):
#			if talking_to_player == false:
#				talking_to_player = true
#				prev_target = target
#				target = player_target
#				calculate_path()
#				ally_state = 6
#				if PlayerData.Player_Information.spoken_to_guard01 == false:
#					PlayerData.Player_Information.spoken_to_guard01 = true
#			elif talking_to_player == true:
#				talking_to_player = false
#				target = prev_target
#				prev_target = null
#				idle_for_a_moment()
#			prev_target = target
#			target = player_target
#			PlayerData.Player_Information.spoken_to_guard01 = true
		if talking_to_player == false:
			level_text.text = "T - Talk to Town Guard"
		elif talking_to_player == true:
			level_text.text = "Someone needs to beat the big zombie. /T-cont."
	
	#----Ally Movement Setion----#
	ally_origin = ally.get_global_transform().origin
	var offset = Vector3()
	if target != null:
		offset = target.get_global_transform().origin - ally_origin
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
	if ally_state == 3:
		if can_attack_timer >=can_attack_time:
			if attack_timer>=attack_time:
				randomize()
				attack = randi()%5+1
				velocity = move_and_slide(Vector3(0,0,0), Vector3(0,1,0))
				var angle = atan2(-hv.x, -hv.z)
				var char_rot = ally.get_rotation()
				char_rot.y = angle
				ally.set_rotation(char_rot)
				attacking = true
				if attack == 1:
					ally_attack1()
				elif attack == 2:
					ally_attack2()
				elif attack == 3:
					ally_attack3()
				elif attack == 4:
					ally_attack4()
				elif attack == 5:
					ally_attack5()
			else:
				attacking = false
	
	elif ally_state == 6:
#		if can_attack_timer >=can_attack_time:
#			if attack_timer>=attack_time:
#				randomize()
#				attack = randi()%5+1
		velocity = move_and_slide(Vector3(0,0,0), Vector3(0,1,0))
		var angle = atan2(-hv.x, -hv.z)
		var char_rot = ally.get_rotation()
		char_rot.y = angle
		ally.set_rotation(char_rot)
#				attacking = true
#				if attack == 1:
#					ally_attack1()
#				elif attack == 2:
#					ally_attack2()
#				elif attack == 3:
#					ally_attack3()
#				elif attack == 4:
#					ally_attack4()
#				elif attack == 5:
#					ally_attack5()
#			else:
#				attacking = false
	
	if can_attack_timer<can_attack_time:
		can_attack_timer += 0.06
	if ally_state == 3:
		if attack_timer<attack_time:
			attack_timer += 0.06
	
	if ally_state == 3:
		get_node("AnimationTreePlayer").blend2_node_set_amount("IdleOrMove", 0)
		if attacking == true:
			if attack == 1:
				#get_node("AnimationTreePlayer").blend3_node_set_amount("DJAttackBlend", -1)
				get_node("AnimationTreePlayer").transition_node_set_current("AttTransition", 0)
				get_node("AnimationTreePlayer").oneshot_node_start("AttOneShot")
			elif attack == 2:
				get_node("AnimationTreePlayer").transition_node_set_current("AttTransition", 1)
				get_node("AnimationTreePlayer").oneshot_node_start("AttOneShot")
			elif attack == 3:
				get_node("AnimationTreePlayer").transition_node_set_current("AttTransition", 2)
				get_node("AnimationTreePlayer").oneshot_node_start("AttOneShot")
			elif attack == 4:
				get_node("AnimationTreePlayer").transition_node_set_current("AttTransition", 3)
				get_node("AnimationTreePlayer").oneshot_node_start("AttOneShot")
			elif attack == 5:
				get_node("AnimationTreePlayer").transition_node_set_current("AttTransition", 4)
				get_node("AnimationTreePlayer").oneshot_node_start("AttOneShot")
	
	if ally_state == 6:
		get_node("AnimationTreePlayer").blend2_node_set_amount("IdleOrMove", 0)

func remove_targets():
	
#	att_area.hide()
#	int_area.hide()
#	det_area.hide()
#	reset_areas_timer.start()
	
	target = null
	idle_for_a_moment()
	print ("target : ", target)

#func _on_RestoreAreasTimer_timeout():
#	att_area.show()
#	int_area.show()
#	det_area.show()

func ally_attack1():
	var area = $Area
	var bodies = area.get_overlapping_bodies()
	var damage
	damage = ally_damage
	for abody in bodies:
		if abody == self:
			continue
		if abody.has_method("zombie_die"): #_hit"):
			abody._hit(damage, 0, area.global_transform.origin)
	can_attack_timer = 0.0
	attack_timer = 0.0

func ally_attack2():
	var area = $Area
	var bodies = area.get_overlapping_bodies()
	var damage
	damage = ally_damage
	for abody in bodies:
		if abody == self:
			continue
		if abody.has_method("zombie_die"): #_hit"):
			abody._hit(damage, 0, area.global_transform.origin)
	can_attack_timer = 0.0
	attack_timer = 0.0

func ally_attack3():
	var area = $Area
	var bodies = area.get_overlapping_bodies()
	var damage
	damage = ally_damage
	for abody in bodies:
		if abody == self:
			continue
		if abody.has_method("zombie_die"): #_hit"):
			abody._hit(damage, 0, area.global_transform.origin)
	can_attack_timer = 0.0
	attack_timer = 0.0

func ally_attack4():
	var area = $Area
	var bodies = area.get_overlapping_bodies()
	var damage
	damage = ally_damage
	for abody in bodies:
		if abody == self:
			continue
		if abody.has_method("zombie_die"): #_hit"):
			abody._hit(damage, 0, area.global_transform.origin)
	can_attack_timer = 0.0
	attack_timer = 0.0

func ally_attack5():
	var area = $Area
	var bodies = area.get_overlapping_bodies()
	var damage
	damage = ally_damage
	for abody in bodies:
		if abody == self:
			continue
		if abody.has_method("zombie_die"): #_hit"):
			abody._hit(damage, 0, area.global_transform.origin)
	can_attack_timer = 0.0
	attack_timer = 0.0

func _on_DetectArea_body_entered(body):
	if body.has_method("zombie_die"): #process_UI"):
		if current_health >= retreat_health:
			is_active = true
			target = body
			ally_state = 2
			dtimer.stop()
			calculate_path()
		else:
			is_active = true
			pick_retreat_waypoint()
			dtimer.stop()

func _on_DetectArea_body_exited(body):
	if body.has_method("zombie_die"):
		is_active = false
		target = null
		idle_for_a_moment()

func _on_AttackArea_body_entered(body):
	if body.has_method("zombie_die"):
		ally_state = 3
		set_physics_process(true)
		set_process(false)
	elif body.has_method("process_UI"):
		ally_state = 0
		set_physics_process(false)
		set_process(false)
		idle_for_a_moment()

func _on_AttackArea_body_exited(body):
	if body.has_method("zombie_die"):
		if current_health >= retreat_health:
			target = body
			ally_state = 2
			calculate_path()
		else:
			pick_retreat_waypoint()

func _hit(damage, type, _hit_pos):
	randomize()
	var hit_points_lost
	if type == 0:
		hit_points_lost = damage - ally_fort
		hit_points_lost = clamp(hit_points_lost, 0, 500)
		current_health -= hit_points_lost
	elif type == 1:
		hit_points_lost = damage - ally_lightning_res
		hit_points_lost = clamp(hit_points_lost, 0, 500)
		current_health -= hit_points_lost
	elif type == 2:
		hit_points_lost = damage - ally_ice_res
		hit_points_lost = clamp(hit_points_lost, 0, 500)
		current_health -= hit_points_lost
	elif type == 3:
		hit_points_lost = damage - ally_fire_res
		hit_points_lost = clamp(hit_points_lost, 0, 500)
		current_health -= hit_points_lost
	elif type == 4:
		hit_points_lost = damage - ally_earth_res
		hit_points_lost = clamp(hit_points_lost, 0, 500)
		current_health -= hit_points_lost
#	hit_sound.play()
	chance_of_attack = randi()%100+1
	chance_of_attack_blocked = ((damage*2)-ally_fort)
	if chance_of_attack <= chance_of_attack_blocked:
		can_attack_timer = 0.0
	PlayerData.points_add(damage)
	if current_health < retreat_health:
		pick_retreat_waypoint()
#	if current_health <= 0:
#		zombie_die()

#func zombie_die():
#	PlayerData.points_add(50)
#	PlayerData.Player_Information.beaten_davey_jones = true
#	queue_free()

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
		ally_state = 0
		set_physics_process(false)
		set_process(false)

func idle_for_a_moment():
	target = null
	dtimer.start()
	ally_state = 0
	set_physics_process(false)
	set_process(false)
	get_node("AnimationTreePlayer").blend2_node_set_amount("IdleOrMove", 0)

func pick_waypoint():
	randomize()
	waypoint_number_chosen = randi()%waypoint_numbers_to_choose_from
	target = ally_waypoints[waypoint_number_chosen]
	ally_state = 1
	calculate_path()

func pick_retreat_waypoint():
	randomize()
	waypoint_number_chosen = randi()%waypoint_numbers_to_choose_from
	target = ally_waypoints[waypoint_number_chosen]
	ally_state = 4
	calculate_path()

#func _on_RegenTimer_timeout():
#	rtimer.start()
#	if current_health < max_health:
#		current_health += health_to_recover
#		current_health = clamp(current_health, 0, max_health)
#	else:
#		pass

func calculate_path():
	if target == null:
		idle_for_a_moment()
		pass
	elif target != null:
		begin = self.global_transform.origin
		end = target.global_transform.origin
	
	var p = navmesh.get_simple_path(begin, end, true)
	path = Array(p)
	path.invert()
	if ally_state == 2:
		set_physics_process(false)
		set_process(true)
	elif ally_state == 4:
		set_physics_process(false)
		set_process(true)
	elif ally_state == 1:
		set_physics_process(false)
		set_process(true)

func _on_Map_Area_body_entered(body):
	if body.has_method("process_UI"):
		is_active = true
		set_process(true)
		track_timer.start()
		dtimer.start()
	else:
		pass

func _on_Map_Area_body_exited(body):
	if body.has_method("process_UI"):
		is_active = false
		set_process(false)
		track_timer.stop()
		dtimer.stop()
	else:
		pass

