extends KinematicBody

var player_object
var player_global_position
var waypoint_object
var random_number
var attack_area_distance = 10
var is_persuing_player = false
var distance_to_player
var move_speed = 150

var accel 
var ACCELL = 1.0
var DEACCEL = 1.0
var character
const ACCEL = 1.0

var speed = 1.5
var forward = Vector3(0,0,-1)

var player_origin
var enemy_origin
var player = null
var enemy

var gravity = -9.8
var velocity = Vector3()

var camera

var is_chasing_player = false
var is_attacking_player = false

var zombie_damage = 30

var can_attack = false
var can_attack_timer = 0.0
var can_attack_time = 10.5
var attacking = false
var attack_timer = 0.0
var attack_time = 3.5

var current_health = 150
var max_health = 150

var hit_sound

var chance_of_attack = 0
var chance_of_attack_blocked = 0
var enemy_fort = 5
var enemy_lightning_res = 5
var enemy_ice_res = 5
var enemy_fire_res = 5
var enemy_earth_res = 5

var attack = 1

func _ready():
	is_chasing_player = false
	is_attacking_player = false
	if player == null:
		player = get_parent().get_parent().get_node("Player")
	enemy = get_node(".")
	set_physics_process(true)
	enemy_origin = enemy.get_global_transform().origin
	get_node("AnimationTreePlayer").set_active(true)
	character = get_node(".")
	hit_sound = $CreatureHit

func _physics_process(delta):
	#called zombie tracker as all code adapted from zombie base code
	zombie_tracker()
	#----Enemy Movement Section----#
	enemy_origin = enemy.get_global_transform().origin
	player_global_position = player.get_global_transform().origin
	var offset = Vector3()
	offset = player_global_position - enemy_origin
	var dir = Vector3()
	dir += offset
	#instead of dir being relative to camera and based on button pressed
	#dir is set to the offset gained from checking locations of self and player
	#calculate movement as in player script
	#need to redo at some point with navmesh to avaoid objects
	dir.y = 0
	dir = dir.normalized()
	velocity.y += delta*gravity
	var hv = velocity
	hv.y = 0
	var target = dir
	var attacking = false
	var MAX_ATTACK_SPEED = 0.0
	var MAX_SPRINT_SPEED = 2.0
	var MAX_SPEED = 1.5
	var is_sprinting = false
	if attacking == true:
		target *= MAX_ATTACK_SPEED
	elif attacking == false:
		if is_sprinting:
			target *= MAX_SPRINT_SPEED
		else:
			target *= MAX_SPEED
	var ATTACK_ACCEL = 1
	var SPRINT_ACCEL = 2
	var accel
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
	hv = hv.linear_interpolate(target, accel*delta)
	velocity.x = hv.x
	velocity.z = hv.z
	#enemy rotation
	if is_chasing_player:
		if is_attacking_player == false:
			velocity = move_and_slide(velocity, Vector3(0,1,0))
			var angle = atan2(hv.x, hv.z)
			var char_rot = character.get_rotation()
			char_rot.y = angle
			character.set_rotation(char_rot)
	#----End of Enemy Movement Section----#
	
	#----Enemy Attack Section----#
	if can_attack_timer<can_attack_time:
		can_attack_timer += 0.06
	if is_attacking_player:
		if attack_timer<attack_time:
			attack_timer += 0.06
	
	if can_attack_timer >=can_attack_time:
		if is_attacking_player:
			if attack_timer>=attack_time:
				#if enemy has more than 1 attack, randomize which one it will do
				randomize()
				attack = randi()%3+1
				velocity = move_and_slide(Vector3(0,0,0), Vector3(0,1,0))
				var angle = atan2(hv.x, hv.z)
				var char_rot = character.get_rotation()
				char_rot.y = angle
				character.set_rotation(char_rot)
				attacking = true
				if attack == 1:
					creature_attack1()
				elif attack == 2:
					creature_attack2()
				elif attack == 3:
					creature_attack3()
	else:
		attacking = false
	var speed 
	if is_chasing_player == true:
		if is_sprinting == true:
			speed = hv.length()/MAX_SPRINT_SPEED
		elif is_sprinting == false:
			speed = hv.length()/MAX_SPEED
	else:
		speed = 0
	
	if is_chasing_player == true:
		get_node("AnimationTreePlayer").blend2_node_set_amount("ZIdleOrMove", speed)
	if is_chasing_player == false:
		get_node("AnimationTreePlayer").blend2_node_set_amount("ZIdleOrMove", speed)
	if is_attacking_player == true:
		if attacking == true:
			if attack == 1:
				get_node("AnimationTreePlayer").blend3_node_set_amount("CAttackBlend", -1)
				get_node("AnimationTreePlayer").oneshot_node_start("COneShot")
			elif attack == 2:
				get_node("AnimationTreePlayer").blend3_node_set_amount("CAttackBlend", 0)
				get_node("AnimationTreePlayer").oneshot_node_start("COneShot")
			elif attack == 3:
				get_node("AnimationTreePlayer").blend3_node_set_amount("CAttackBlend", 1)
				get_node("AnimationTreePlayer").oneshot_node_start("COneShot")

func creature_attack1():
	var area = $Area
	var bodies = area.get_overlapping_bodies()
	var damage
	damage = zombie_damage
	for body in bodies:
		if body == self:
			continue
		if body.has_method("_hit"):
			body._hit(damage, 0, area.global_transform.origin)
	can_attack_timer = 0.0
	attack_timer = 0.0

func creature_attack2():
	var area = $Area
	var bodies = area.get_overlapping_bodies()
	var damage
	damage = zombie_damage
	for body in bodies:
		if body == self:
			continue
		if body.has_method("_hit"):
			body._hit(damage, 0, area.global_transform.origin)
	can_attack_timer = 0.0
	attack_timer = 0.0

func creature_attack3():
	var area = $Area
	var bodies = area.get_overlapping_bodies()
	var damage
	damage = zombie_damage
	for body in bodies:
		if body == self:
			continue
		if body.has_method("_hit"):
			body._hit(damage, 0, area.global_transform.origin)
	can_attack_timer = 0.0
	attack_timer = 0.0

func _on_Detect_Area_body_entered(body):
	if body.has_method("process_UI"):
		is_chasing_player = true

func _on_Detect_Area_body_exited(body):
	if body.has_method("process_UI"):
		is_chasing_player = false

func _on_Attack_Area_body_entered(body):
	if body.has_method("process_UI"):
		is_attacking_player = true

func _on_Attack_Area_body_exited(body):
	if body.has_method("process_UI"):
		is_attacking_player = false

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
	chance_of_attack = randi()%100+1    #chance of enemy still being able to attack
	chance_of_attack_blocked = ((damage*2)-enemy_fort)    #chance of attack being blocked by player
	if chance_of_attack <= chance_of_attack_blocked:
		can_attack_timer = 0.0
	PlayerData.points_add(damage)
	if current_health <= 0:
		zombie_die()

func zombie_die():
	PlayerData.points_add(30)
	queue_free()

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
