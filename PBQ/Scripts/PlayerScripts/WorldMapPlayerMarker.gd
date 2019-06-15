extends KinematicBody

var marker01
var marker02
var marker03
var marker04
var marker05
var marker06
var marker07
var marker08
var marker09

var travel_speed = 5.0

var world_label01
var world_label02
var world_label03
var world_label04
var world_label05
var world_label06
var world_label07

onready var save_popup = $SavePopup

var player_position = Vector3()
var marker_position = Vector3()
var move_speed = 15.0
var slow_speed = 3.0
var velocity = Vector3()
var gravity = 0.0

onready var down_arrow = $WorldHud/WorldLabel01/ArrowPointerDown
onready var up_arrow = $WorldHud/WorldLabel02/ArrowPointerUp
onready var left_arrow = $WorldHud/WorldLabel03/ArrowPointerLeft
onready var right_arrow = $WorldHud/WorldLabel04/ArrowPointerRight

func _ready():
	marker01 = get_parent().get_node("WorldMapMarkersHolder/Marker01")
	marker02 = get_parent().get_node("WorldMapMarkersHolder/Marker02")
	marker03 = get_parent().get_node("WorldMapMarkersHolder/Marker03")
	marker04 = get_parent().get_node("WorldMapMarkersHolder/Marker04")
	marker05 = get_parent().get_node("WorldMapMarkersHolder/Marker05")
	marker06 = get_parent().get_node("WorldMapMarkersHolder/Marker06")
	marker07 = get_parent().get_node("WorldMapMarkersHolder/Marker07")
	marker08 = get_parent().get_node("WorldMapMarkersHolder/Marker08")
	marker09 = get_parent().get_node("WorldMapMarkersHolder/Marker09")
	
	if PlayerData.Player_Information.current_level == 1:
		self.global_transform = marker01.global_transform
	elif PlayerData.Player_Information.current_level == 2:
		self.global_transform = marker02.global_transform
	elif PlayerData.Player_Information.current_level == 3:
		self.global_transform = marker03.global_transform
	elif PlayerData.Player_Information.current_level == 4:
		self.global_transform = marker04.global_transform
	elif PlayerData.Player_Information.current_level == 5:
		self.global_transform = marker05.global_transform
	elif PlayerData.Player_Information.current_level == 6:
		self.global_transform = marker06.global_transform
	elif PlayerData.Player_Information.current_level == 7:
		self.global_transform = marker07.global_transform
	elif PlayerData.Player_Information.current_level == 8:
		self.global_transform = marker08.global_transform
	elif PlayerData.Player_Information.current_level == 9:
		self.global_transform = marker09.global_transform
	
	world_label01 = $WorldHud/WorldLabel01
	world_label02 = $WorldHud/WorldLabel02
	world_label03 = $WorldHud/WorldLabel03
	world_label04 = $WorldHud/WorldLabel04
	world_label05 = $WorldHud/WorldLabel05
	world_label06 = $WorldHud/WorldLabel06
	world_label07 = $WorldHud/WorldLabel07
	world_label06.text = "T - Save Options"
	world_label07.text = "I - Shop"

func move_to_marker (marker, delta):
	player_position = self.get_global_transform().origin
	marker_position = marker.get_global_transform().origin
	var offset = Vector3()
	offset = marker_position - player_position
	var dir = Vector3()
	dir += offset
	#dir is set to the offset gained from checking locations
	#calculate movement as in enemy scripts, but without gravity
	dir = dir.normalized()
	var hv = velocity
	var target = dir
	var attacking = false

	target *= move_speed
	var ATTACK_ACCEL = 1
	var SPRINT_ACCEL = 2
	var accel
	if dir.dot(hv) > 0:
		accel = travel_speed
	else:
		accel = slow_speed
	hv = hv.linear_interpolate(target, accel*delta)
	velocity.x = hv.x
	velocity.z = hv.z
	velocity.y = hv.y
	
	velocity = move_and_slide(velocity, Vector3(0,1,0))

func _physics_process(delta):
	if PlayerData.Player_Information.current_level == 1:
		world_label05.text = "Space - Enter Level 01 Castle 01"
		if(Input.is_action_just_pressed("jump")):
			get_node("/root/PlayerData").goto_scene("res://Scenes/LevelScenes/LevelsMainLoading.tscn")
		if PlayerData.Player_Information.level02unlocked == true:
			world_label01.text = "S - Level 02 Town 01"
			down_arrow.show()
			if(Input.is_action_just_pressed("move_backward")):
				PlayerData.Player_Information.current_level = 2
		else:
			world_label01.text = ""
			down_arrow.hide()
		if PlayerData.Player_Information.level07unlocked == true:
			world_label02.text = "W - Level 07 Town 03"
			up_arrow.show()
			if(Input.is_action_just_pressed("move_forward")):
				PlayerData.Player_Information.current_level = 7
		else:
			world_label02.text = ""
			up_arrow.hide()
		if PlayerData.Player_Information.level04unlocked == true:
			world_label03.text = "A - Level 04 Town 02"
			left_arrow.show()
			if(Input.is_action_just_pressed("move_left")):
				PlayerData.Player_Information.current_level = 4
		else:
			world_label03.text = ""
			left_arrow.hide()
		world_label04.text = ""
		right_arrow.hide()
		move_to_marker(marker01, delta)
	
	elif PlayerData.Player_Information.current_level == 2:
		world_label05.text = "Space - Enter Level 02 Town 01"
		if(Input.is_action_just_pressed("jump")):
			get_node("/root/PlayerData").goto_scene("res://Scenes/LevelScenes/LevelsMainLoading.tscn")
		if PlayerData.Player_Information.level03unlocked == true:
			world_label01.text = "S - Level 03 Town 01"
			down_arrow.show()
			if(Input.is_action_just_pressed("move_backward")):
				PlayerData.Player_Information.current_level = 3
		else:
			world_label01.text = ""
			down_arrow.hide()
		if PlayerData.Player_Information.level01unlocked == true:
			world_label02.text = "W - Level 01 Castle 01"
			up_arrow.show()
			if(Input.is_action_just_pressed("move_forward")):
				PlayerData.Player_Information.current_level = 1
		else:
			world_label02.text = ""
			up_arrow.hide()
		if PlayerData.Player_Information.level04unlocked == true:
			world_label03.text = "A - Level 04 Town 02"
			left_arrow.show()
			if(Input.is_action_just_pressed("move_left")):
				PlayerData.Player_Information.current_level = 4
		else:
			world_label03.text = ""
			left_arrow.hide()
		world_label04.text = ""
		right_arrow.hide()
		move_to_marker(marker02, delta)
	
	elif PlayerData.Player_Information.current_level == 3:
		world_label05.text = "Space - Enter Level 03 Town 01"
		if(Input.is_action_just_pressed("jump")):
			get_node("/root/PlayerData").goto_scene("res://Scenes/LevelScenes/LevelsMainLoading.tscn")
		if PlayerData.Player_Information.level02unlocked == true:
			world_label02.text = "W - Level 02 Town 01"
			up_arrow.show()
			if(Input.is_action_just_pressed("move_forward")):
				PlayerData.Player_Information.current_level = 2
		else:
			world_label02.text = ""
			up_arrow.hide()
		if PlayerData.Player_Information.level04unlocked == true:
			world_label03.text = "A - Level 04 Town 02"
			left_arrow.show()
			if(Input.is_action_just_pressed("move_left")):
				PlayerData.Player_Information.current_level = 4
		else:
			world_label03.text = ""
			left_arrow.hide()
		world_label04.text = ""
		right_arrow.hide()
		world_label01.text = ""
		down_arrow.hide()
		move_to_marker(marker03, delta)
	
	elif PlayerData.Player_Information.current_level == 4:
		world_label05.text = "Space - Enter Level 04 Town 02"
		if(Input.is_action_just_pressed("jump")):
			get_node("/root/PlayerData").goto_scene("res://Scenes/LevelScenes/LevelsMainLoading.tscn")
		if PlayerData.Player_Information.level02unlocked == true:
			world_label04.text = "D - Level 02 Town 01"
			right_arrow.show()
			if(Input.is_action_just_pressed("move_right")):
				PlayerData.Player_Information.current_level = 2
		else:
			world_label04.text = ""
			right_arrow.hide()
		if PlayerData.Player_Information.level06unlocked == true:
			world_label02.text = "W - Level 06 Town 02"
			up_arrow.show()
			if(Input.is_action_just_pressed("move_forward")):
				PlayerData.Player_Information.current_level = 6
		else:
			world_label02.text = ""
			up_arrow.hide()
		if PlayerData.Player_Information.level05unlocked == true:
			world_label03.text = "A - Level 05 Citadel"
			left_arrow.show()
			if(Input.is_action_just_pressed("move_left")):
				PlayerData.Player_Information.current_level = 5
		else:
			world_label03.text = ""
			left_arrow.hide()
		world_label01.text = ""
		down_arrow.hide()
		move_to_marker(marker04, delta)
	
	elif PlayerData.Player_Information.current_level == 5:
		world_label05.text = "Space - Enter Level 05 Citadel"
		if(Input.is_action_just_pressed("jump")):
			get_node("/root/PlayerData").goto_scene("res://Scenes/LevelScenes/LevelsMainLoading.tscn")
		if PlayerData.Player_Information.level04unlocked == true:
			world_label01.text = "S - Level 04 Town 02"
			down_arrow.show()
			if(Input.is_action_just_pressed("move_backward")):
				PlayerData.Player_Information.current_level = 4
		else:
			world_label01.text = ""
			down_arrow.hide()
		if PlayerData.Player_Information.level07unlocked == true:
			world_label02.text = "W - Level 07 Town 03"
			up_arrow.show()
			if(Input.is_action_just_pressed("move_forward")):
				PlayerData.Player_Information.current_level = 7
		else:
			world_label02.text = ""
			up_arrow.hide()
		if PlayerData.Player_Information.level06unlocked == true:
			world_label04.text = "D - Level 06 Town 02"
			right_arrow.show()
			if(Input.is_action_just_pressed("move_right")):
				PlayerData.Player_Information.current_level = 6
		else:
			world_label04.text = ""
			right_arrow.hide()
		world_label03.text = ""
		left_arrow.hide()
		move_to_marker(marker05, delta)
	
	elif PlayerData.Player_Information.current_level == 6:
		world_label05.text = "Space - Enter Level 06 Town 02"
		if(Input.is_action_just_pressed("jump")):
			get_node("/root/PlayerData").goto_scene("res://Scenes/LevelScenes/LevelsMainLoading.tscn")
		if PlayerData.Player_Information.level04unlocked == true:
			world_label01.text = "S - Level 04 Town 02"
			down_arrow.show()
			if(Input.is_action_just_pressed("move_backward")):
				PlayerData.Player_Information.current_level = 4
		else:
			world_label01.text = ""
			down_arrow.hide()
		if PlayerData.Player_Information.level07unlocked == true:
			world_label02.text = "W - Level 07 Town 03"
			up_arrow.show()
			if(Input.is_action_just_pressed("move_forward")):
				PlayerData.Player_Information.current_level = 7
		else:
			world_label02.text = ""
			up_arrow.hide()
		if PlayerData.Player_Information.level02unlocked == true:
			world_label04.text = "D - Level 02 Town 01"
			right_arrow.show()
			if(Input.is_action_just_pressed("move_right")):
				PlayerData.Player_Information.current_level = 2
		else:
			world_label04.text = ""
			right_arrow.hide()
		if PlayerData.Player_Information.level05unlocked == true:
			world_label03.text = "A - Level 05 Citadel"
			left_arrow.show()
			if(Input.is_action_just_pressed("move_left")):
				PlayerData.Player_Information.current_level = 5
		else:
			world_label03.text = ""
			left_arrow.hide()
		move_to_marker(marker06, delta)
	
	elif PlayerData.Player_Information.current_level == 7:
		world_label05.text = "Space - Enter Level 07 Town 03"
		if(Input.is_action_just_pressed("jump")):
			get_node("/root/PlayerData").goto_scene("res://Scenes/LevelScenes/LevelsMainLoading.tscn")
		if PlayerData.Player_Information.level04unlocked == true:
			world_label01.text = "S - Level 04 Town 02"
			down_arrow.show()
			if(Input.is_action_just_pressed("move_backward")):
				PlayerData.Player_Information.current_level = 4
		else:
			world_label01.text = ""
			down_arrow.hide()
		if PlayerData.Player_Information.level08unlocked == true:
			world_label02.text = "W - Level 08 LightHouse"
			up_arrow.show()
			if(Input.is_action_just_pressed("move_forward")):
				PlayerData.Player_Information.current_level = 8
		else:
			world_label02.text = ""
			up_arrow.hide()
		if PlayerData.Player_Information.level09unlocked == true:
			world_label04.text = "D - Level 09 Castle 02"
			right_arrow.show()
			if(Input.is_action_just_pressed("move_right")):
				PlayerData.Player_Information.current_level = 9
		else:
			world_label04.text = ""
			right_arrow.hide()
		world_label03.text = ""
		left_arrow.hide()
		move_to_marker(marker07, delta)
	
	elif PlayerData.Player_Information.current_level == 8:
		world_label05.text = "Space - Enter Level 08 LightHouse"
		if(Input.is_action_just_pressed("jump")):
			get_node("/root/PlayerData").goto_scene("res://Scenes/LevelScenes/LevelsMainLoading.tscn")
		if PlayerData.Player_Information.level07unlocked == true:
			world_label01.text = "S - Level 07 Town 03"
			down_arrow.show()
			if(Input.is_action_just_pressed("move_backward")):
				PlayerData.Player_Information.current_level = 7
		else:
			world_label01.text = ""
			down_arrow.hide()
		if PlayerData.Player_Information.level09unlocked == true:
			world_label04.text = "D - Level 09 Castle 02"
			right_arrow.show()
			if(Input.is_action_just_pressed("move_right")):
				PlayerData.Player_Information.current_level = 9
		else:
			world_label04.text = ""
			right_arrow.hide()
		world_label02.text = ""
		up_arrow.hide()
		world_label03.text = ""
		left_arrow.hide()
		move_to_marker(marker08, delta)
	
	elif PlayerData.Player_Information.current_level == 9:
		world_label05.text = "Space - Enter Level 09 Castle 02"
		if(Input.is_action_just_pressed("jump")):
			get_node("/root/PlayerData").goto_scene("res://Scenes/LevelScenes/LevelsMainLoading.tscn")
		if PlayerData.Player_Information.level02unlocked == true:
			world_label01.text = "S - Level 02 Town 01"
			down_arrow.show()
			if(Input.is_action_just_pressed("move_backward")):
				PlayerData.Player_Information.current_level = 2
		else:
			world_label01.text = ""
			down_arrow.hide()
		if PlayerData.Player_Information.level08unlocked == true:
			world_label02.text = "W - Level 08 Light House"
			up_arrow.show()
			if(Input.is_action_just_pressed("move_forward")):
				PlayerData.Player_Information.current_level = 8
		else:
			world_label02.text = ""
			up_arrow.hide()
		if PlayerData.Player_Information.level07unlocked == true:
			world_label03.text = "A - Level 07 Town 03"
			left_arrow.show()
			if(Input.is_action_just_pressed("move_left")):
				PlayerData.Player_Information.current_level = 7
		else:
			world_label03.text = ""
			left_arrow.hide()
		world_label04.text = ""
		right_arrow.hide()
		move_to_marker(marker09, delta)
	
	if (Input.is_action_just_pressed("interaction_button")):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		save_popup.popup()

func _restart_level():
	self.global_transform = marker01.global_transform

func _on_SaveButton1_pressed():
	Global_Player.save_data_01()
	save_popup.hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_SaveButton2_pressed():
	Global_Player.save_data_02()
	save_popup.hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_SaveButton3_pressed():
	Global_Player.save_data_03()
	save_popup.hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_SaveButton4_pressed():
	Global_Player.save_data_04()
	save_popup.hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_CancelButton_pressed():
	save_popup.hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
