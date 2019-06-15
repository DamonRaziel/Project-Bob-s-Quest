extends Camera

export var distance = 4.0
export var closest_distance = 0.5
export var furthest_distance = 8
export var height = 2.0
export var aiming_distance = 0.7
export var non_aiming_distance = 4.0
export(int, "Visible", "Hidden", "Caputered, Confined") var mouse_mode = 2
# Mouselook settings
export var mouselook = true
export (float, 0.0, 0.999, 0.001) var smoothness = 0.5 setget set_smoothness
export (int, 0, 360) var yaw_limit = 360
export (int, 0, 360) var pitch_limit = 360
var _mouse_position = Vector2(0.0, 0.0)
var _yaw = 0.0
var _pitch = 0.0
var _total_yaw = 0.0
var _total_pitch = 0.0

var target1
var pos1
var up1
var offset1

var target_test

var player_model = null
var collision_exception =[]
export var collisions = true setget set_collisions

func _ready():
	set_physics_process(true)
	set_as_toplevel(true)
	_yaw = 0.0
	_pitch = 0.0
	_total_yaw = 0.0
	_total_pitch = 0.0

func _input(event):
	if event is InputEventMouseMotion:
			_mouse_position = event.relative

func set_smoothness(value):
	smoothness = clamp(value, 0.001, 0.999)

func set_distance(value):
	distance = max(0, value)

func set_collisions(value):
	collisions = value

func _update_mouselook():
	_mouse_position *= PlayerData.Options_Data.look_sensitivity 
	_yaw = _yaw * smoothness + _mouse_position.x * (1.0 - smoothness)
	_pitch = _pitch * smoothness + _mouse_position.y * (1.0 - smoothness)
	_mouse_position = Vector2(0, 0)
	
	if yaw_limit < 360:
		_yaw = clamp(_yaw, -yaw_limit - _total_yaw, yaw_limit - _total_yaw)
	if pitch_limit < 360:
		_pitch = clamp(_pitch, -pitch_limit - _total_pitch, pitch_limit - _total_pitch)
	
	_total_yaw += _yaw
	_total_pitch += _pitch
	
	var target = get_parent().get_global_transform().origin
	var offset = get_translation().distance_to(target)
	
	set_translation(target)
	rotate_y(deg2rad(-_yaw))
	rotate_object_local(Vector3(1,0,0), deg2rad(-_pitch))
	translate(Vector3(0.0, 0.0, offset))

func _physics_process(delta):
	_update_mouselook()
	target1 = get_parent().get_global_transform().origin
	pos1 = get_global_transform().origin
	up1 = Vector3(0,1,0)

	offset1 = pos1-target1
	offset1 = offset1.normalized()*distance
	pos1 = target1+offset1
	
	if PlayerData.current_player_aiming_style == 0:
		if distance > non_aiming_distance:
			distance -= 0.1
		elif distance < non_aiming_distance:
			distance += 0.1
		if Input.is_action_pressed("ui_up"): #closer
			if distance > closest_distance:
				distance -= 0.1
				non_aiming_distance = distance
		if Input.is_action_pressed("ui_down"): #further
			if distance < furthest_distance:
				distance += 0.1
				non_aiming_distance = distance
	elif PlayerData.current_player_aiming_style == 1:
		if distance > aiming_distance:
			distance -= 0.1
	
	look_at_from_position(pos1, target1, up1)
	
	var space_state = get_world().get_direct_space_state()
	var obstacle = space_state.intersect_ray(target1, pos1)
	if not obstacle.empty():
		set_translation(obstacle.position)
