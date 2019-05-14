extends KinematicBody
#adapted from older player control script
# replace player finding script, incorporated rather than wholly replaced
#something similar to script for when body entered, eg if body has method "is player" , player = body, done
#and on player exit area, if has method "is player", player = null, done
#make it not rely upon absolute path of player nodes, done (i think, ish)

#add in way point system, done
#change movement script to use navmesh, done
#use finite state machine setup instead of if statements? done (i think, ish)

#need to add in retreat system and hp recovery

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

#var is_chasing_player = false
#var is_attacking_player = false
#var is_retreating = false
#var is_wandering = false
#var is_idle = true

var zombie_damage = 55

var can_attack_timer = 0.0
var can_attack_time = 10.5
var attacking = false
var attack_timer = 0.0
var attack_time = 3.5
var attack = 1

var current_health = 400
var max_health = 400
var health_to_recover = 10
var retreat_health = 50
#keep max for when implement enemy healing

var hit_sound

var chance_of_attack = 0
var chance_of_attack_blocked = 0
var enemy_fort = 5
var enemy_lightning_res = 5
var enemy_ice_res = 5
var enemy_fire_res = 5
var enemy_earth_res = 5

#var player = null
var target = null
var retreat_target = null
#var player_global_position
#var target_global_position

var navmesh
var navmeshpath
var path = []
#var m = SpatialMaterial.new()
#var draw_path = false

var begin = Vector3()
var end = Vector3()

var waypoint_numbers_to_choose_from
var waypoint_number_chosen

#set wntcf in ready (=parent.parent,getnode(array).getchildrenresultvar
#if state = 0, start timer
#when timer times out, make decision
#if decision is 0, start idle again
#if decision is 1, set state to 1
#choose random number between 0 and wntcf
#wnc = random number generated
#target = parent.parent.getnode(waypointsholder).arrayvar(arrayentrynumber)

var enemy_state = 0
#0 = idle, 1 = wander randomly, 2 = chase player, 3 = attack player, 4 = retreat

var dtimer
var decision

var rtimer
#var ptimer

var enemy_waypoints

func _ready():
#	is_chasing_player = false
#	is_attacking_player = false
	enemy_state = 0
#	if player == null:
#		player = get_parent().get_parent().get_node("Player")
	enemy = get_node(".")
	set_physics_process(true)
	enemy_origin = enemy.get_global_transform().origin
	get_node("AnimationTreePlayer").set_active(true)
	hit_sound = $CreatureHit
	navmesh = get_parent().get_parent()
	enemy_waypoints = navmesh.get_node("WaypointsHolder").waypoints
	
	waypoint_numbers_to_choose_from = navmesh.get_node("WaypointsHolder").waypoints_number# - 1
	dtimer = get_node("DecisionTimer")
	dtimer.start()
	
	rtimer = get_node("RegenTimer")

func _physics_process(delta):
	zombie_tracker()
	#----Enemy Movement Setion----#
	enemy_origin = enemy.get_global_transform().origin
#	player_global_position = player.get_global_transform().origin
	#only calculate these if the enemy is moving, so if not idle??
	#if enemy_state != 0:
		#why is it hard to figure out somewhere else to put these? changes here can break things
	var offset = Vector3()
	if target != null:
		offset = target.get_global_transform().origin - enemy_origin
	else:
		offset = null
	var dir = Vector3()
	
	if target != null:
		dir += offset
		#as explained in other script (Creature.gd)
		dir.y = 0
		dir = dir.normalized()
	else:
		dir = null
#
#	if enemy_state == 4:
#		if target != null:
#			dir -= offset
#			#as explained in other script (Creature.gd)
#			dir.y = 0
#			#dir = dir.normalized()
#			#means the further away, he faster they move, how to fix?, gives some unexpected results
#		else:
#			dir = null
#	else:
#		if target != null:
#			dir += offset
#			#as explained in other script (Creature.gd)
#			dir.y = 0
#			dir = dir.normalized()
#		else:
#			dir = null
	
	
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
#	var retreat_accel = -1
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
	
#	if target != null:
#		if dir.dot(hv) > 0:
#			if attacking == true:
#				accel = ATTACK_ACCEL
#			elif attacking == false:
#				if enemy_state == 4:
#					accel = retreat_accel
#				else:
#					accel = ACCEL
##				if is_sprinting:
##					accel = SPRINT_ACCEL
##				else:
##					accel = ACCEL
#		else:
#			accel = DEACCEL
	
		hv = hv.linear_interpolate(mtarget, accel*delta)
		velocity.x = hv.x
		velocity.z = hv.z
	
	#enemy states
	if enemy_state == 1:
		#if is_attacking_player == false:
#		var p = navmesh.get_simple_path(self.global_transform.origin, target.global_transform.origin, true) #get_simple_path(begin, end, true)
#		path = Array(p) # Vector3array too complex to use, convert to regular array
#		path.invert()
		#set_process(true)
#		if (draw_path):
#			var im = get_parent().get_parent().get_node("draw")
#			im.set_material_override(m)
#			im.clear()
#			im.begin(Mesh.PRIMITIVE_POINTS, null)
#			im.add_vertex(self.global_transform.origin) #begin)
#			im.add_vertex(target.global_transform.origin) #end)
#			im.end()
#			im.begin(Mesh.PRIMITIVE_LINE_STRIP, null)
#			for x in p:
#				im.add_vertex(x)
#			im.end()
		
		#navmeshpath = navmesh.get_simple_path(self.global_transform.origin, target.global_transform.origin, true)
		var to_walk = delta*speed
		#var to_watch = offset #Vector3(0, 1, 0)
#			if (path.size() > 1):
		#var to_walk = delta*SPEED
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
			var atdir = -to_watch
			atdir.y = 0
			
			var t = Transform()
			t.origin = atpos
			t=t.looking_at(atpos + atdir, Vector3(0, 1, 0))
#			var angle = atan2(hv.x, hv.z)
#			var char_rot = enemy.get_rotation()
#			char_rot.y = angle
#			enemy.set_rotation(char_rot)
			self.set_transform(t)
			
			if (path.size() < 2):
				path = []
				idle_for_a_moment()
				#enemy_state = 0
	
	elif enemy_state == 2:
		#if is_attacking_player == false:
		#need to update path in somewhere other than process update so that it doesnt run every frame
		#needs to be easily updatable to follow the player though?
		#how to track player movement changing?
#		var p = navmesh.get_simple_path(self.global_transform.origin, target.global_transform.origin, true) #get_simple_path(begin, end, true)
#		path = Array(p) # Vector3array too complex to use, convert to regular array
#		path.invert()
		#set_process(true)
#		if (draw_path):
#			var im = get_parent().get_parent().get_node("draw")
#			im.set_material_override(m)
#			im.clear()
#			im.begin(Mesh.PRIMITIVE_POINTS, null)
#			im.add_vertex(self.global_transform.origin) #begin)
#			im.add_vertex(target.global_transform.origin) #end)
#			im.end()
#			im.begin(Mesh.PRIMITIVE_LINE_STRIP, null)
#			for x in p:
#				im.add_vertex(x)
#			im.end()
		
		#navmeshpath = navmesh.get_simple_path(self.global_transform.origin, target.global_transform.origin, true)
		var to_walk = delta*speed
		#var to_watch = offset #Vector3(0, 1, 0)
#			if (path.size() > 1):
		#var to_walk = delta*SPEED
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
			var atdir = -to_watch
			atdir.y = 0
			
			var t = Transform()
			t.origin = atpos
			t=t.looking_at(atpos + atdir, Vector3(0, 1, 0))
#			var angle = atan2(hv.x, hv.z)
#			var char_rot = enemy.get_rotation()
#			char_rot.y = angle
#			enemy.set_rotation(char_rot)
			self.set_transform(t)
			
			if (path.size() < 2):
				path = []
				#ptimer.start()
				calculate_path()
				#enemy_state = 3
				#is_chasing_player = false
				#set_process(false)
	elif enemy_state == 4:
#		var p = navmesh.get_simple_path(self.global_transform.origin, target.global_transform.origin, true)
#		path = Array(p)
#		path.invert()
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
			var atdir = -to_watch
			atdir.y = 0
			
			var t = Transform()
			t.origin = atpos
			t=t.looking_at(atpos + atdir, Vector3(0, 1, 0))
			self.set_transform(t)
			
			if (path.size() < 2):
				path = []
				idle_for_a_moment()
#		velocity = move_and_slide(velocity, Vector3(0,1,0))
#		var angle = atan2(hv.x, hv.z)
#		var char_rot = enemy.get_rotation()
#		char_rot.y = angle
#		enemy.set_rotation(char_rot)
#		attacking = false
#	else:
#		is_chasing_player = false
# put else after all other options

			#set_process(false)
#			var atpos = self.global_transform.origin
#			var atdir = to_watch
#			atdir.y = 0
#
#			var t = Transform()
#			t.origin = atpos
#			t=t.looking_at(atpos + atdir, Vector3(0, 1, 0))
#			self.set_transform(t)
			#get_node("robot_base").set_transform(t)
			#velocity = move_and_slide(velocity, Vector3(0,1,0))
#			var angle = atan2(hv.x, hv.z)
#			var char_rot = enemy.get_rotation()
#			char_rot.y = angle
#			enemy.set_rotation(char_rot)
	#----End of Movement Section----#
	
	#----Attack Section----#
	#enemy attack
	elif enemy_state == 3:
		if can_attack_timer >=can_attack_time:
		#if is_attacking_player:
			if attack_timer>=attack_time:
				randomize()
				attack = randi()%3+1
				velocity = move_and_slide(Vector3(0,0,0), Vector3(0,1,0))
				#look_at(target, Vector3(0, 1, 0))
				var angle = atan2(hv.x, hv.z)
				var char_rot = enemy.get_rotation()
				char_rot.y = angle
				enemy.set_rotation(char_rot)
				attacking = true
				#zombie_attack()
				if attack == 1:
					creature_attack1()
				elif attack == 2:
					creature_attack2()
				elif attack == 3:
					creature_attack3()
			else:
				attacking = false
		#enemy_state = 0
	
	if can_attack_timer<can_attack_time:
		can_attack_timer += 0.06
	if enemy_state == 3:
		if attack_timer<attack_time:
			attack_timer += 0.06
	
	var anim_speed 
	if enemy_state == 2:
		if is_sprinting == true:
			anim_speed = hv.length()/MAX_SPRINT_SPEED
		elif is_sprinting == false:
			anim_speed = hv.length()/MAX_SPEED
	else:
		anim_speed = 0
	if enemy_state == 0:
		get_node("AnimationTreePlayer").blend2_node_set_amount("ZIdleOrMove", 0)
	if enemy_state == 1:
		get_node("AnimationTreePlayer").blend2_node_set_amount("ZIdleOrMove", 1)
	if enemy_state == 2:
		get_node("AnimationTreePlayer").blend2_node_set_amount("ZIdleOrMove", anim_speed)
	if enemy_state == 4:
		get_node("AnimationTreePlayer").blend2_node_set_amount("ZIdleOrMove", 1)
#	if enemy_state != 2:
#		get_node("AnimationTreePlayer").blend2_node_set_amount("ZIdleOrMove", anim_speed)
	if enemy_state == 3:
		get_node("AnimationTreePlayer").blend2_node_set_amount("ZIdleOrMove", 0)
		if attacking == true:
			if attack == 1:
				get_node("AnimationTreePlayer").blend3_node_set_amount("HandAttackBlend", -1)
				get_node("AnimationTreePlayer").blend2_node_set_amount("AttackBlend", 0)
				get_node("AnimationTreePlayer").oneshot_node_start("AttackOneShot")
			elif attack == 2:
				get_node("AnimationTreePlayer").blend3_node_set_amount("HandAttackBlend", 0)
				get_node("AnimationTreePlayer").blend2_node_set_amount("AttackBlend", 0)
				get_node("AnimationTreePlayer").oneshot_node_start("AttackOneShot")
			elif attack == 3:
				get_node("AnimationTreePlayer").blend3_node_set_amount("HandAttackBlend", 1)
				get_node("AnimationTreePlayer").blend2_node_set_amount("AttackBlend", 0)
				get_node("AnimationTreePlayer").oneshot_node_start("AttackOneShot")
	#somehow broken??
#	var speed 
#	if enemy_state == 2:
#		speed = hv.length()/MAX_SPEED
#	elif enemy_state == 1:
#		speed = hv.length()/MAX_SPEED
##	elif enemy_state == 3:
##		speed = hv.length()/MAX_ATTACK_SPEED
#	else:
#		speed = 0
#	if enemy_state == 0:
#		get_node("AnimationTreePlayer").blend2_node_set_amount("ZIdleOrMove", 0) #speed)
#	elif enemy_state == 1:
#		get_node("AnimationTreePlayer").blend2_node_set_amount("ZIdleOrMove", 1) #speed)
#	elif enemy_state == 2:
#		get_node("AnimationTreePlayer").blend2_node_set_amount("ZIdleOrMove", 1) #speed)
#	if enemy_state == 3:
#		if attacking == true:
#			get_node("AnimationTreePlayer").oneshot_node_start("ZOneShot")

func creature_attack1():
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

func creature_attack2():
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

func creature_attack3():
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

#func _on_Detect_Area_body_entered(body):
##	if body.has_method("_is_a_navmesh"):
##		navmesh = body
#	if body.has_method("process_UI"):
#		target = body
#		enemy_state = 2
#		dtimer.stop()
#		#ptimer.start()

func _on_Detect_Area_body_entered(body):
#	if body.has_method("_is_a_navmesh"):
#		navmesh = body
	if body.has_method("process_UI"):
		if current_health >= retreat_health:
			target = body
			enemy_state = 2
			dtimer.stop()
			calculate_path()
		else:
			pick_retreat_waypoint()
#			target = body
#			enemy_state = 4
			dtimer.stop()

func _on_Detect_Area_body_exited(body):
#	if body.has_method("_is_a_navmesh"):
#		navmesh = null
	if body.has_method("process_UI"):
		#target = null
		#set zombie to idle before going back to random
		target = null
		#enemy_state = 0
		idle_for_a_moment()
		

func _on_Attack_Area_body_entered(body):
	if body.has_method("process_UI"):
		#target = body #does this need to be here again?
		#retreat_target = body
		enemy_state = 3
		#ptimer.stop()

#func _on_Attack_Area_body_exited(body):
#	if body.has_method("process_UI"):
#		#is_attacking_player = false
#		target = body
#		enemy_state = 2
#		#ptimer.start()

func _on_Attack_Area_body_exited(body):
	if body.has_method("process_UI"):
		if current_health >= retreat_health:
			target = body
			enemy_state = 2
			#dtimer.stop()
			calculate_path()
		else:
			pick_retreat_waypoint()
			#enemy_state = 4
			#dtimer.stop()

func _hit(damage, type, _hit_pos):
	randomize()
	var hit_points_lost
	if type == 0:
		hit_points_lost = damage - enemy_fort
		hit_points_lost = clamp(hit_points_lost, 0, 500)
		current_health -= hit_points_lost
		print (hit_points_lost)
	elif type == 1:
		hit_points_lost = damage - enemy_lightning_res
		hit_points_lost = clamp(hit_points_lost, 0, 500)
		current_health -= hit_points_lost
		print (hit_points_lost)
	elif type == 2:
		hit_points_lost = damage - enemy_ice_res
		hit_points_lost = clamp(hit_points_lost, 0, 500)
		current_health -= hit_points_lost
		print (hit_points_lost)
	elif type == 3:
		hit_points_lost = damage - enemy_fire_res
		hit_points_lost = clamp(hit_points_lost, 0, 500)
		current_health -= hit_points_lost
		print (hit_points_lost)
	elif type == 4:
		hit_points_lost = damage - enemy_earth_res
		hit_points_lost = clamp(hit_points_lost, 0, 500)
		current_health -= hit_points_lost
		print (hit_points_lost)
	hit_sound.play()
	chance_of_attack = randi()%100+1
	chance_of_attack_blocked = ((damage*2)-enemy_fort)
	if chance_of_attack <= chance_of_attack_blocked:
		can_attack_timer = 0.0
	PlayerData.points_add(damage)
	if current_health < retreat_health:
		pick_retreat_waypoint()
#		target = retreat_target
#		enemy_state = 4
	if current_health <= 0:
		zombie_die()

func zombie_die():
	PlayerData.points_add(50)
	PlayerData.Player_Information.beaten_creature_boss = true
	queue_free()

func _on_DecisionTimer_timeout():
	randomize()
	decision = randi()%2
	if decision == 0:
		idle_for_a_moment()
	elif decision == 1:
		pick_waypoint()
	print ("decision was ", decision)

func idle_for_a_moment():
	dtimer.start()
	enemy_state = 0

func pick_waypoint():
	randomize()
	waypoint_number_chosen = randi()%waypoint_numbers_to_choose_from
	target = enemy_waypoints[waypoint_number_chosen]
	print ("waypoint chosen = ", waypoint_number_chosen)
	enemy_state = 1
	calculate_path()
	#ptimer.start()

func pick_retreat_waypoint():
	randomize()
	waypoint_number_chosen = randi()%waypoint_numbers_to_choose_from
	target = enemy_waypoints[waypoint_number_chosen]
	print ("retreat waypoint chosen = ", waypoint_number_chosen)
	enemy_state = 4
	calculate_path()

#func _on_PathTimer_timeout():
#	var p = navmesh.get_simple_path(self.global_transform.origin, target.global_transform.origin, true) #get_simple_path(begin, end, true)
#	path = Array(p) # Vector3array too complex to use, convert to regular array
#	path.invert()

func _on_RegenTimer_timeout():
	#if hp less than maxhp, add extra hp (clamped to max), else, pass, continous checking every couple of seconds or so
	rtimer.start()
	if current_health < max_health:
		current_health += health_to_recover
		current_health = clamp(current_health, 0, max_health)
		print("current helath = ", current_health)
	else:
		pass

func calculate_path():
	var p = navmesh.get_simple_path(self.global_transform.origin, target.global_transform.origin, true)
	path = Array(p)
	path.invert()
