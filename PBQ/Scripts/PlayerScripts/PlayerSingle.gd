extends KinematicBody

#movement vars
var gravity = -9.8
var velocity = Vector3()
var is_jumping
var is_sprinting = false
var is_defending = false

#animation vars
var shoot_blend = 0
#MovementTransition ANIM_TRACKER
var anim = 0
const ANIM_FLOOR = 0
const ANIM_JUMP = 1
const ANIM_DEFEND = 2
# WeaponTransition ANIM_TRACKER
const WEAPON_ANIMS_UNARMED = 0
const WEAPON_ANIMS_1HANDED = 1
const WEAPON_ANIMS_2HANDED = 2
const WEAPON_ANIMS_BOW = 3
const WEAPON_ANIMS_JUMP = 4

#attack vars
var strength = 10
var attacking = false
var attack_time = 4.5
var attack_timer = 0.0
var combo_time = 3.0
var combo = 0
var bow_release_time = 1.5
const SHOOT_TIME = 1.5
const SHOOT_SCALE = 2
var can_attack = false
var prev_shoot = false
var arrow_point
var magic_point
var magic_timer
var weapon_left_point
var weapon_right_point
var arrow_timer
#attack animation vars
var unarmedcombo1animplay = false
var unarmedcombo2animplay = false
var unarmedcombo3animplay = false
var onehandedcombo1animplay = false
var onehandedcombo2animplay = false
var onehandedcombo3animplay = false
var twohandedcombo1animplay = false
var twohandedcombo2animplay = false
var twohandedcombo3animplay = false
var unarmedjumpattackanimplay = false
var onehandedjumpattackanimplay = false
var twohandedjumpattackanimplay = false
var bowdrawanimplay = false
var bowreleaseanimplay = false
var jumpunarmedanimplay = false
var jumponehandedanimplay = false
var jumptwohandedanimplay = false
var magicattackanimplay =  false

#shield vars
var shield_right_point

# UI Variables
var UI_Status_Label_01
var UI_Status_Label_02
var UI_Status_Label_03
var UI_Status_Label_04
var UI_Status_Label_05
var UI_Status_Label_06
var UI_Status_label_07
var UI_Status_Label_08
var UI_Status_Label_09
var UI_Status_Label_10

var HP_Progress_Bar
var Mana_Progress_Bar

var inventory_node

#respawn vars
var respawn_point = Vector3()

#camera, aiming, and rotation vars
var camera
var character
var skel
var spine_bone = "Spine.Middle"
var spine_angle = Vector3()
var spine_angle_resting = 14.16
var cam_pitch
var cam_yaw
var aim_pos
var non_aim_pos
var cursor

var is_under_effect = false
var effects_timer
var strength_mod = 0
var speed_mod = 0
var fort_mod = 0

#sound effects vars
var p_hit
var p_jump
var p_pickup
var p_weapon
var p_fire
var p_firelong
var p_ice
var p_lightning
var p_earth

var map

onready var slots_hint_shower = get_node("Inventory/SlotsPanel/SlotsBGShow")

onready var weapon_display_image = get_node("HUD/Background/Weapon_Rect/WeaponDisplay")
onready var arrows_display = get_node("HUD/Background/Weapon_Rect/ArrowLabel")

onready var combo_indicator = get_node("HUD/Background/Combo_Rect/Combo_Ind")
onready var combo_counter = get_node("HUD/Background/Combo_Rect/ComboCounter")
onready var combo_blank = preload("res://HUDElements/WeaponIconsHUD/HUDAttackBlank.png")
onready var combo_possible = preload("res://HUDElements/WeaponIconsHUD/HUDAttackCanCombo.png")
onready var combo_count1 = preload("res://HUDElements/WeaponIconsHUD/HUDAttackComboCount1.png")
onready var combo_count2 = preload("res://HUDElements/WeaponIconsHUD/HUDAttackComboCount2.png")
onready var combo_count3 = preload("res://HUDElements/WeaponIconsHUD/HUDAttackComboCount3.png")
var combo_indicator_show = false

#mesh setup vars
onready var base_male = get_node("ArmaturePlayer01/Skeleton/PlayerBaseMale")
onready var hair_male = get_node("ArmaturePlayer01/Skeleton/PlayerHairMale")
onready var base_female = get_node("ArmaturePlayer01/Skeleton/PlayerBaseFemale")
onready var hair_female = get_node("ArmaturePlayer01/Skeleton/PlayerHairFemale")

#materials setup vars
onready var player_mat_red = preload("res://ModelsNew/ModelsPlayer/Player1Mat.material")
onready var player_mat_blue = preload("res://ModelsNew/ModelsPlayer/Player02Mat.material")
onready var player_mat_orange = preload("res://ModelsNew/ModelsPlayer/Player3Mat.material")

#armour setup vars
var chainmail_mesh
var scalemail_mesh
var fullplate_mesh

onready var chainmail_male = get_node("ArmaturePlayer01/Skeleton/PlayerChainmailMale")
onready var scalemail_male = get_node("ArmaturePlayer01/Skeleton/PlayerScalemailMale")
onready var fullplate_male = get_node("ArmaturePlayer01/Skeleton/PlayerFullPlateMale")
onready var chainmail_female = get_node("ArmaturePlayer01/Skeleton/PlayerChainmailFemale")
onready var scalemail_female = get_node("ArmaturePlayer01/Skeleton/PlayerScalemailFemale")
onready var fullplate_female = get_node("ArmaturePlayer01/Skeleton/PlayerFullPlateFemale")

var carrying_object = false
var object_being_carried = null
var grabbed_object_pos
var grabbed_object_pos2

var player_sound_listener
var player_sound_volume
var player_sound_stream

func _ready():
	#first check which player we are meant to be, and setup meshes and materials for character
	if PlayerData.Player_Information.player_name == "Bob":
		base_male.set_surface_material(0, player_mat_red)
		base_female.queue_free()
		hair_female.queue_free()
	elif PlayerData.Player_Information.player_name == "Frank":
		base_male.set_surface_material(0, player_mat_blue)
		base_female.queue_free()
		hair_female.queue_free()
	elif PlayerData.Player_Information.player_name == "Dave":
		base_male.set_surface_material(0, player_mat_orange)
		base_female.queue_free()
		hair_female.queue_free()
	elif PlayerData.Player_Information.player_name == "Bobbi":
		base_female.set_surface_material(0, player_mat_red)
		base_male.queue_free()
		hair_male.queue_free()
	elif PlayerData.Player_Information.player_name == "Frankie":
		base_female.set_surface_material(0, player_mat_blue)
		base_male.queue_free()
		hair_male.queue_free()
	elif PlayerData.Player_Information.player_name == "Neng":
		base_female.set_surface_material(0, player_mat_orange)
		base_male.queue_free()
		hair_male.queue_free()
	#set up armour nodes as they are a sub mesh of players
	if PlayerData.Player_Information.player_name == "Bob" or PlayerData.Player_Information.player_name == "Frank" or PlayerData.Player_Information.player_name == "Dave":
		chainmail_mesh = chainmail_male
		chainmail_female.queue_free()
		scalemail_mesh = scalemail_male
		scalemail_female.queue_free()
		fullplate_mesh = fullplate_male
		fullplate_female.queue_free()
	elif PlayerData.Player_Information.player_name == "Bobbi" or PlayerData.Player_Information.player_name == "Frankie" or PlayerData.Player_Information.player_name == "Neng":
		chainmail_mesh = chainmail_female
		chainmail_male.queue_free()
		scalemail_mesh = scalemail_female
		scalemail_male.queue_free()
		fullplate_mesh = fullplate_female
		fullplate_male.queue_free()
	#setup the UI nodes
	UI_Status_Label_01 = $HUD/Background/Health_Rect/Health_Label
	UI_Status_Label_02 = $HUD/Background/Mana_Rect/Mana_Label
	UI_Status_Label_03 = $HUD/Background/Gold_Rect/Gold_Label
	UI_Status_Label_04 = $HUD/Background/Weapon_Rect/Weapon_Label
	UI_Status_Label_05 = $HUD/Background/Weapon_Rect2/Item_Label
	UI_Status_Label_06 = $HUD/Background/Combo_Rect/ComboLabel
	UI_Status_label_07 = $HUD/Background/FPS_Rect/FPSLabel
	UI_Status_Label_08 = $HUD/Background/Points_Rect/PointsLabel
	UI_Status_Label_09 = $HUD/Background/PitchAndYaw/PYLabel
	UI_Status_Label_10 = $HUD/Background/Player_Vol/Player_Vol_Label
	HP_Progress_Bar = $HUD/Background/Health_Rect/HPTextProg
	Mana_Progress_Bar = $HUD/Background/Mana_Rect/ManaTextProg
	#setup the animation nodes
	get_node("AnimationTreePlayer").set_active(true)
	character = get_node(".")
	#set mouse mode to captured
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#setup equipment and attack points
	arrow_point = $ArmaturePlayer01/Skeleton/UpperSpineBone/ArrowPoint02
	#arrow_point.player_node = self
	arrow_timer = $rotation_target/target/ArrowTimer
	magic_point = $ArmaturePlayer01/Skeleton/UpperSpineBone/MagicPoint
	#magic_point.player_node = self
	magic_timer = $rotation_target/target/MagicTimer
	weapon_left_point = $ArmaturePlayer01/Skeleton/LeftHand/Spatial
	#weapon_left_point.player_node = self
	weapon_right_point = $ArmaturePlayer01/Skeleton/RightHand/Spatial
	#weapon_right_point.player_node = self
	shield_right_point=$ArmaturePlayer01/Skeleton/RShieldAttach/ShieldAttachR
	#setup aiming nodes
	skel = $ArmaturePlayer01/Skeleton
	cam_pitch = $rotation_target/target/Camera._total_pitch
	cam_yaw = $rotation_target/target/Camera._total_yaw
	aim_pos = $AimPos
	non_aim_pos = $NonAimPos
	cursor = $ArmaturePlayer01/Skeleton/UpperSpineBone/ArrowPoint02/CursorScene
	cursor.hide()
	#set up other nodes
	inventory_node = $Inventory
	respawn_point = get_parent().get_node("RespawnPoint")
	effects_timer = $EffectTimer
	map = $rotation_target/target/Camera/MapContainer/Viewport/Map
	#set up player equiped weapons
	#print ("player weapon slot is : ", PlayerData.Player_Information.player_current_weapon_slot_number)
#	if PlayerData.Player_Information.player_current_weapon_slot_number == 1:
#		PlayerData.Player_Information.player_current_weapon_number = Global_Player.inventory_equiped_items.inventory_weapons1 # weapon_to_assign
#		if PlayerData.Player_Information.player_current_weapon_number == 1 && PlayerData.Player_Information.player_weapon_in_scene != 1:
#			weapon_left_point.add_sword_to_scene()
#			PlayerData.Player_Information.player_weapon_in_scene = 1
#		elif PlayerData.Player_Information.player_current_weapon_number == 2 && PlayerData.Player_Information.player_weapon_in_scene != 2:
#			weapon_left_point.add_lightning_sword_to_scene()
#			PlayerData.Player_Information.player_weapon_in_scene = 2
#		elif PlayerData.Player_Information.player_current_weapon_number == 3 && PlayerData.Player_Information.player_weapon_in_scene != 3:
#			weapon_left_point.add_axe_to_scene()
#			PlayerData.Player_Information.player_weapon_in_scene = 3
#		elif PlayerData.Player_Information.player_current_weapon_number == 4 && PlayerData.Player_Information.player_weapon_in_scene != 4:
#			weapon_left_point.add_ice_axe_to_scene()
#			PlayerData.Player_Information.player_weapon_in_scene = 4
#		elif PlayerData.Player_Information.player_current_weapon_number == 5 && PlayerData.Player_Information.player_weapon_in_scene != 5:
#			weapon_left_point.add_claymore_to_scene()
#			PlayerData.Player_Information.player_weapon_in_scene = 5
#		elif PlayerData.Player_Information.player_current_weapon_number == 6 && PlayerData.Player_Information.player_weapon_in_scene != 6:
#			weapon_left_point.add_fire_claymore_to_scene()
#			PlayerData.Player_Information.player_weapon_in_scene = 6
#		elif PlayerData.Player_Information.player_current_weapon_number == 7 && PlayerData.Player_Information.player_weapon_in_scene != 7:
#			weapon_left_point.add_warhammer_to_scene()
#			PlayerData.Player_Information.player_weapon_in_scene = 7
#		elif PlayerData.Player_Information.player_current_weapon_number == 8 && PlayerData.Player_Information.player_weapon_in_scene != 8:
#			weapon_left_point.add_earth_warhammer_to_scene()
#			PlayerData.Player_Information.player_weapon_in_scene = 8
#		elif PlayerData.Player_Information.player_current_weapon_number == 9 && PlayerData.Player_Information.player_weapon_in_scene != 9:
#			weapon_right_point.add_straight_bow_to_scene()
#			PlayerData.Player_Information.player_weapon_in_scene = 9
#		elif PlayerData.Player_Information.player_current_weapon_number == 10 && PlayerData.Player_Information.player_weapon_in_scene != 10:
#			weapon_right_point.add_recurve_bow_to_scene()
#			PlayerData.Player_Information.player_weapon_in_scene = 10
#	elif PlayerData.Player_Information.player_current_weapon_slot_number == 2:
#		PlayerData.Player_Information.player_current_weapon_number = Global_Player.inventory_equiped_items.inventory_weapons1 # weapon_to_assign
#		if PlayerData.Player_Information.player_current_weapon_number == 1 && PlayerData.Player_Information.player_weapon_in_scene != 1:
#			weapon_left_point.add_sword_to_scene()
#			PlayerData.Player_Information.player_weapon_in_scene = 1
#		elif PlayerData.Player_Information.player_current_weapon_number == 2 && PlayerData.Player_Information.player_weapon_in_scene != 2:
#			weapon_left_point.add_lightning_sword_to_scene()
#			PlayerData.Player_Information.player_weapon_in_scene = 2
#		elif PlayerData.Player_Information.player_current_weapon_number == 3 && PlayerData.Player_Information.player_weapon_in_scene != 3:
#			weapon_left_point.add_axe_to_scene()
#			PlayerData.Player_Information.player_weapon_in_scene = 3
#		elif PlayerData.Player_Information.player_current_weapon_number == 4 && PlayerData.Player_Information.player_weapon_in_scene != 4:
#			weapon_left_point.add_ice_axe_to_scene()
#			PlayerData.Player_Information.player_weapon_in_scene = 4
#		elif PlayerData.Player_Information.player_current_weapon_number == 5 && PlayerData.Player_Information.player_weapon_in_scene != 5:
#			weapon_left_point.add_claymore_to_scene()
#			PlayerData.Player_Information.player_weapon_in_scene = 5
#		elif PlayerData.Player_Information.player_current_weapon_number == 6 && PlayerData.Player_Information.player_weapon_in_scene != 6:
#			weapon_left_point.add_fire_claymore_to_scene()
#			PlayerData.Player_Information.player_weapon_in_scene = 6
#		elif PlayerData.Player_Information.player_current_weapon_number == 7 && PlayerData.Player_Information.player_weapon_in_scene != 7:
#			weapon_left_point.add_warhammer_to_scene()
#			PlayerData.Player_Information.player_weapon_in_scene = 7
#		elif PlayerData.Player_Information.player_current_weapon_number == 8 && PlayerData.Player_Information.player_weapon_in_scene != 8:
#			weapon_left_point.add_earth_warhammer_to_scene()
#			PlayerData.Player_Information.player_weapon_in_scene = 8
#		elif PlayerData.Player_Information.player_current_weapon_number == 9 && PlayerData.Player_Information.player_weapon_in_scene != 9:
#			weapon_right_point.add_straight_bow_to_scene()
#			PlayerData.Player_Information.player_weapon_in_scene = 9
#		elif PlayerData.Player_Information.player_current_weapon_number == 10 && PlayerData.Player_Information.player_weapon_in_scene != 10:
#			weapon_right_point.add_recurve_bow_to_scene()
#			PlayerData.Player_Information.player_weapon_in_scene = 10
#	elif PlayerData.Player_Information.player_current_weapon_slot_number == 3:
#		PlayerData.Player_Information.player_current_weapon_number = Global_Player.inventory_equiped_items.inventory_weapons1 # weapon_to_assign
#		if PlayerData.Player_Information.player_current_weapon_number == 1 && PlayerData.Player_Information.player_weapon_in_scene != 1:
#			weapon_left_point.add_sword_to_scene()
#			PlayerData.Player_Information.player_weapon_in_scene = 1
#		elif PlayerData.Player_Information.player_current_weapon_number == 2 && PlayerData.Player_Information.player_weapon_in_scene != 2:
#			weapon_left_point.add_lightning_sword_to_scene()
#			PlayerData.Player_Information.player_weapon_in_scene = 2
#		elif PlayerData.Player_Information.player_current_weapon_number == 3 && PlayerData.Player_Information.player_weapon_in_scene != 3:
#			weapon_left_point.add_axe_to_scene()
#			PlayerData.Player_Information.player_weapon_in_scene = 3
#		elif PlayerData.Player_Information.player_current_weapon_number == 4 && PlayerData.Player_Information.player_weapon_in_scene != 4:
#			weapon_left_point.add_ice_axe_to_scene()
#			PlayerData.Player_Information.player_weapon_in_scene = 4
#		elif PlayerData.Player_Information.player_current_weapon_number == 5 && PlayerData.Player_Information.player_weapon_in_scene != 5:
#			weapon_left_point.add_claymore_to_scene()
#			PlayerData.Player_Information.player_weapon_in_scene = 5
#		elif PlayerData.Player_Information.player_current_weapon_number == 6 && PlayerData.Player_Information.player_weapon_in_scene != 6:
#			weapon_left_point.add_fire_claymore_to_scene()
#			PlayerData.Player_Information.player_weapon_in_scene = 6
#		elif PlayerData.Player_Information.player_current_weapon_number == 7 && PlayerData.Player_Information.player_weapon_in_scene != 7:
#			weapon_left_point.add_warhammer_to_scene()
#			PlayerData.Player_Information.player_weapon_in_scene = 7
#		elif PlayerData.Player_Information.player_current_weapon_number == 8 && PlayerData.Player_Information.player_weapon_in_scene != 8:
#			weapon_left_point.add_earth_warhammer_to_scene()
#			PlayerData.Player_Information.player_weapon_in_scene = 8
#		elif PlayerData.Player_Information.player_current_weapon_number == 9 && PlayerData.Player_Information.player_weapon_in_scene != 9:
#			weapon_right_point.add_straight_bow_to_scene()
#			PlayerData.Player_Information.player_weapon_in_scene = 9
#		elif PlayerData.Player_Information.player_current_weapon_number == 10 && PlayerData.Player_Information.player_weapon_in_scene != 10:
#			weapon_right_point.add_recurve_bow_to_scene()
#			PlayerData.Player_Information.player_weapon_in_scene = 10
#	else:
#		PlayerData.Player_Information.player_current_weapon_number = 0
#		PlayerData.Player_Information.player_weapon_in_scene = 0
	
	if PlayerData.Player_Information.player_current_weapon_number == 1:# && PlayerData.Player_Information.player_weapon_in_scene != 1:
		weapon_left_point.add_sword_to_scene()
		PlayerData.Player_Information.player_weapon_in_scene = 1
	elif PlayerData.Player_Information.player_current_weapon_number == 2:# && PlayerData.Player_Information.player_weapon_in_scene != 2:
		weapon_left_point.add_lightning_sword_to_scene()
		PlayerData.Player_Information.player_weapon_in_scene = 2
	elif PlayerData.Player_Information.player_current_weapon_number == 3:# && PlayerData.Player_Information.player_weapon_in_scene != 3:
		weapon_left_point.add_axe_to_scene()
		PlayerData.Player_Information.player_weapon_in_scene = 3
	elif PlayerData.Player_Information.player_current_weapon_number == 4:# && PlayerData.Player_Information.player_weapon_in_scene != 4:
		weapon_left_point.add_ice_axe_to_scene()
		PlayerData.Player_Information.player_weapon_in_scene = 4
	elif PlayerData.Player_Information.player_current_weapon_number == 5:# && PlayerData.Player_Information.player_weapon_in_scene != 5:
		weapon_left_point.add_claymore_to_scene()
		PlayerData.Player_Information.player_weapon_in_scene = 5
	elif PlayerData.Player_Information.player_current_weapon_number == 6:# && PlayerData.Player_Information.player_weapon_in_scene != 6:
		weapon_left_point.add_fire_claymore_to_scene()
		PlayerData.Player_Information.player_weapon_in_scene = 6
	elif PlayerData.Player_Information.player_current_weapon_number == 7:# && PlayerData.Player_Information.player_weapon_in_scene != 7:
		weapon_left_point.add_warhammer_to_scene()
		PlayerData.Player_Information.player_weapon_in_scene = 7
	elif PlayerData.Player_Information.player_current_weapon_number == 8:# && PlayerData.Player_Information.player_weapon_in_scene != 8:
		weapon_left_point.add_earth_warhammer_to_scene()
		PlayerData.Player_Information.player_weapon_in_scene = 8
	elif PlayerData.Player_Information.player_current_weapon_number == 9:# && PlayerData.Player_Information.player_weapon_in_scene != 9:
		weapon_right_point.add_straight_bow_to_scene()
		PlayerData.Player_Information.player_weapon_in_scene = 9
	elif PlayerData.Player_Information.player_current_weapon_number == 10:# && PlayerData.Player_Information.player_weapon_in_scene != 10:
		weapon_right_point.add_recurve_bow_to_scene()
		PlayerData.Player_Information.player_weapon_in_scene = 10
	else:
		PlayerData.Player_Information.player_current_weapon_number = -1 #0
		PlayerData.Player_Information.player_weapon_in_scene = -1 #0
	
	#check arrows to load numbers
	Global_Player.arrows_check()
	#set up equiped armour and shields
	PlayerData.Player_Information.player_current_armour_number = Global_Player.inventory_equiped_items.inventory_armour1
	if PlayerData.Player_Information.player_current_armour_number == 16:
		chainmail_mesh.show()
	else:
		chainmail_mesh.hide()
	if PlayerData.Player_Information.player_current_armour_number == 17:
		scalemail_mesh.show()
	else:
		scalemail_mesh.hide()
	if PlayerData.Player_Information.player_current_armour_number == 18:
		fullplate_mesh.show()
	else:
		fullplate_mesh.hide()
	
	if PlayerData.Player_Information.player_current_shield_number == 39:
		shield_right_point.add_buckler_to_scene()
	elif PlayerData.Player_Information.player_current_shield_number == 40:
		shield_right_point.add_small_to_scene()
	elif PlayerData.Player_Information.player_current_shield_number == 40:
		shield_right_point.add_medium_to_scene()
	elif PlayerData.Player_Information.player_current_shield_number == 40:
		shield_right_point.add_tower_to_scene()
	else:
		PlayerData.Player_Information.player_current_shield_number = 0
	
	PlayerData.Player_Information.player_current_item_number = 0
	
	#setip sound effects
	p_hit = $Sounds/PlayerHit
	p_jump = $Sounds/PlayerJump
	p_pickup = $Sounds/PlayerPickup
	p_weapon = $Sounds/PlayerWeapon
	p_fire = $Sounds/PlayerFire
	p_firelong = $Sounds/PlayerFireLong
	p_ice = $Sounds/PlayerIce
	p_lightning = $Sounds/PlayerLightning
	p_earth = $Sounds/PlayerEarth
	
	#setup extra HUD components
	if PlayerData.Options_Data.slots_hint_show == 0:
		slots_hint_shower.show()
	elif PlayerData.Options_Data.slots_hint_show == 1:
		slots_hint_shower.hide()
	
	if PlayerData.Player_Information.player_current_weapon_number != -1:
		weapon_display_image.show()
		var slot_image_getter = PlayerData.Player_Information.player_current_weapon_number
		weapon_display_image.set_texture(ResourceLoader.load(Global_ItemDatabase.get_item(slot_image_getter)["hudicon"]))
	else:
		weapon_display_image.hide()
	
	combo_indicator.hide()
	combo_counter.hide()
	grabbed_object_pos = $ArmaturePlayer01/Skeleton/UpperSpineBone/GrabArea/GrabbedHoldPos
	grabbed_object_pos2 = $ArmaturePlayer01/Skeleton/UpperSpineBone/GrabArea/GrabbedHoldPos2
	
	player_sound_listener = $Sounds/PlayerListener
	player_sound_stream = $Sounds/PlayerWeapon

func set_bone_rot(bone, ang):
	#used for aiming, adapted from skeleton demo
	var b = skel.find_bone(bone)
	var rest = skel.get_bone_rest(b)
	var newpose = rest.rotated(Vector3(1.0, 0.0, 0.0), deg2rad(ang))
	skel.set_bone_pose(b, newpose)

func process_UI(delta):
	#set the HUD, keep some hashed out, can be used for debug/checks
#	UI_Status_Label_01.text = "Health: " + str(PlayerData.Player_Information.player_health) + "/" + str(PlayerData.Player_Information.player_max_health)
#	UI_Status_Label_02.text = "Mana: " + str(PlayerData.Player_Information.player_mana) + "/" + str(PlayerData.Player_Information.player_max_mana)
#	UI_Status_Label_03.text = "Coins: " + str(Global_Player.coin_counter) + " / Aiming: " + str(PlayerData.current_player_aiming_style)
#	if PlayerData.Player_Information.player_current_weapon_number >=0 and PlayerData.Player_Information.player_current_weapon_number <=8:
#		UI_Status_Label_04.text = "Weapon: " + str(PlayerData.Player_Information.player_current_weapon_number)
#	elif PlayerData.Player_Information.player_current_weapon_number >=9:
#		UI_Status_Label_04.text = "Weapon: " + str(PlayerData.Player_Information.player_current_weapon_number) + "Arrows: " + str(Global_Player.normal_arrow_counter)
#	if PlayerData.Player_Information.player_current_weapon_number == 9 or PlayerData.Player_Information.player_current_weapon_number == 10:
#		arrows_display.text = str(Global_Player.normal_arrow_counter)
#	else:
#		arrows_display.text = ""
#	UI_Status_Label_05.text = str(PlayerData.Player_Information.player_lives) #"Lives: " + str(PlayerData.Player_Information.player_lives)
#	UI_Status_label_07.text = "FPS: " + str(Engine.get_frames_per_second())
#	UI_Status_Label_08.text = "Points: " + str(PlayerData.Player_Information.player_points)
#	UI_Status_Label_09.text = "Pitch:" + str(cam_pitch) + " /Yaw:" + str(cam_yaw)
	if PlayerData.Options_Data.language == "English":
		UI_Status_Label_01.text = "Health: " + str(PlayerData.Player_Information.player_health) + "/" + str(PlayerData.Player_Information.player_max_health)
		UI_Status_Label_02.text = "Mana: " + str(PlayerData.Player_Information.player_mana) + "/" + str(PlayerData.Player_Information.player_max_mana)
		UI_Status_Label_03.text = "Coins: " + str(Global_Player.coin_counter) + " / Aiming: " + str(PlayerData.current_player_aiming_style)
		if PlayerData.Player_Information.player_current_weapon_number >=0 and PlayerData.Player_Information.player_current_weapon_number <=8:
			UI_Status_Label_04.text = "Weapon: " + str(PlayerData.Player_Information.player_current_weapon_number)
		elif PlayerData.Player_Information.player_current_weapon_number >=9:
			UI_Status_Label_04.text = "Weapon: " + str(PlayerData.Player_Information.player_current_weapon_number) + "Arrows: " + str(Global_Player.normal_arrow_counter)
		if PlayerData.Player_Information.player_current_weapon_number == 9 or PlayerData.Player_Information.player_current_weapon_number == 10:
			arrows_display.text = str(Global_Player.normal_arrow_counter)
		else:
			arrows_display.text = ""
		UI_Status_Label_05.text = str(PlayerData.Player_Information.player_lives) #"Lives: " + str(PlayerData.Player_Information.player_lives)
		UI_Status_label_07.text = "FPS: " + str(Engine.get_frames_per_second())
		UI_Status_Label_08.text = "Points: " + str(PlayerData.Player_Information.player_points)
		UI_Status_Label_09.text = "Pitch:" + str(cam_pitch) + " /Yaw:" + str(cam_yaw)
	elif PlayerData.Options_Data.language == "Spanish":
		UI_Status_Label_01.text = "Salud: " + str(PlayerData.Player_Information.player_health) + "/" + str(PlayerData.Player_Information.player_max_health)
		UI_Status_Label_02.text = "Mana: " + str(PlayerData.Player_Information.player_mana) + "/" + str(PlayerData.Player_Information.player_max_mana)
		UI_Status_Label_03.text = "Monedas: " + str(Global_Player.coin_counter) + " / Punteria: " + str(PlayerData.current_player_aiming_style)
		if PlayerData.Player_Information.player_current_weapon_number >=0 and PlayerData.Player_Information.player_current_weapon_number <=8:
			UI_Status_Label_04.text = "Arma: " + str(PlayerData.Player_Information.player_current_weapon_number)
		elif PlayerData.Player_Information.player_current_weapon_number >=9:
			UI_Status_Label_04.text = "Arma: " + str(PlayerData.Player_Information.player_current_weapon_number) + "Flechas: " + str(Global_Player.normal_arrow_counter)
		if PlayerData.Player_Information.player_current_weapon_number == 9 or PlayerData.Player_Information.player_current_weapon_number == 10:
			arrows_display.text = str(Global_Player.normal_arrow_counter)
		else:
			arrows_display.text = ""
		UI_Status_Label_05.text = str(PlayerData.Player_Information.player_lives) #"Lives: " + str(PlayerData.Player_Information.player_lives)
		UI_Status_label_07.text = "FPS: " + str(Engine.get_frames_per_second())
		UI_Status_Label_08.text = "Puntos: " + str(PlayerData.Player_Information.player_points)
		UI_Status_Label_09.text = "Tono:" + str(cam_pitch) + " /Guinada:" + str(cam_yaw)
	elif PlayerData.Options_Data.language == "Filipino":
		UI_Status_Label_01.text = "Kalusugan: " + str(PlayerData.Player_Information.player_health) + "/" + str(PlayerData.Player_Information.player_max_health)
		UI_Status_Label_02.text = "Mana: " + str(PlayerData.Player_Information.player_mana) + "/" + str(PlayerData.Player_Information.player_max_mana)
		UI_Status_Label_03.text = "Barya: " + str(Global_Player.coin_counter) + " / Pagpuntirya: " + str(PlayerData.current_player_aiming_style)
		if PlayerData.Player_Information.player_current_weapon_number >=0 and PlayerData.Player_Information.player_current_weapon_number <=8:
			UI_Status_Label_04.text = "Armas: " + str(PlayerData.Player_Information.player_current_weapon_number)
		elif PlayerData.Player_Information.player_current_weapon_number >=9:
			UI_Status_Label_04.text = "Armas: " + str(PlayerData.Player_Information.player_current_weapon_number) + "Mga Arrow: " + str(Global_Player.normal_arrow_counter)
		if PlayerData.Player_Information.player_current_weapon_number == 9 or PlayerData.Player_Information.player_current_weapon_number == 10:
			arrows_display.text = str(Global_Player.normal_arrow_counter)
		else:
			arrows_display.text = ""
		UI_Status_Label_05.text = str(PlayerData.Player_Information.player_lives) #"Lives: " + str(PlayerData.Player_Information.player_lives)
		UI_Status_label_07.text = "FPS: " + str(Engine.get_frames_per_second())
		UI_Status_Label_08.text = "Mga Puntos: " + str(PlayerData.Player_Information.player_points)
		UI_Status_Label_09.text = "Pitch:" + str(cam_pitch) + " /Yaw:" + str(cam_yaw)
	
	HP_Progress_Bar.max_value = PlayerData.Player_Information.player_max_health
	HP_Progress_Bar.value = PlayerData.Player_Information.player_health
	Mana_Progress_Bar.max_value = PlayerData.Player_Information.player_max_mana
	Mana_Progress_Bar.value = PlayerData.Player_Information.player_mana
	
	if PlayerData.Options_Data.slots_hint_show == 0:
		slots_hint_shower.show()
	elif PlayerData.Options_Data.slots_hint_show == 1:
		slots_hint_shower.hide()
	
	if PlayerData.Player_Information.player_current_weapon_number > 0: # != -1:
		weapon_display_image.show()
		var slot_image_getter = PlayerData.Player_Information.player_current_weapon_number
		weapon_display_image.set_texture(ResourceLoader.load(Global_ItemDatabase.get_item(slot_image_getter)["hudicon"]))
	else:
		weapon_display_image.hide()
	
	if combo_indicator_show == true:
		combo_indicator.show()
		combo_indicator.set_texture(combo_possible)
	else:
		combo_indicator.hide()
	
	if combo == 0:
		combo_counter.hide()
	else:
		combo_counter.show()
	if combo == 1:
		combo_counter.set_texture(combo_count1)
	elif combo == 2:
		combo_counter.set_texture(combo_count2)
	elif combo == 3:
		combo_counter.set_texture(combo_count3)
	
	#display player volume
	UI_Status_Label_10.text = str(player_sound_volume)

func _input(event): 
	#shield quick equip added
	#meant to toggle, but doesn't work yet
	if Input.is_action_just_pressed("zero"):
		if Global_Player.inventory_equiped_items.inventory_shield1 != -1:
			PlayerData.Player_Information.player_current_shield_number = Global_Player.inventory_equiped_items.inventory_shield1
			if PlayerData.Player_Information.player_current_shield_number == 39:
				shield_right_point.add_buckler_to_scene()
			elif PlayerData.Player_Information.player_current_shield_number == 40:
				shield_right_point.add_small_to_scene()
			elif PlayerData.Player_Information.player_current_shield_number == 41:
				shield_right_point.add_medium_to_scene()
			elif PlayerData.Player_Information.player_current_shield_number == 42:
				shield_right_point.add_tower_to_scene()
		else:
			PlayerData.Player_Information.player_current_shield_number = 0
	#---- Weapon Quick Change ----#
	if Input.is_action_just_pressed("one"):
		PlayerData.Player_Information.player_current_weapon_slot_number = 1
		if carrying_object == true:
			throw_object()
		if Global_Player.inventory_equiped_items.inventory_weapons1 != -1:
			#could condense this part into a separate function that is called instead?
			#would save repeating blocks of code
			PlayerData.Player_Information.player_current_weapon_number = Global_Player.inventory_equiped_items.inventory_weapons1
			if PlayerData.Player_Information.player_current_weapon_number == 1 && PlayerData.Player_Information.player_weapon_in_scene != 1:
				weapon_left_point.add_sword_to_scene()
				PlayerData.Player_Information.player_weapon_in_scene = 1
			elif PlayerData.Player_Information.player_current_weapon_number == 2 && PlayerData.Player_Information.player_weapon_in_scene != 2:
				weapon_left_point.add_lightning_sword_to_scene()
				PlayerData.Player_Information.player_weapon_in_scene = 2
			elif PlayerData.Player_Information.player_current_weapon_number == 3 && PlayerData.Player_Information.player_weapon_in_scene != 3:
				weapon_left_point.add_axe_to_scene()
				PlayerData.Player_Information.player_weapon_in_scene = 3
			elif PlayerData.Player_Information.player_current_weapon_number == 4 && PlayerData.Player_Information.player_weapon_in_scene != 4:
				weapon_left_point.add_ice_axe_to_scene()
				PlayerData.Player_Information.player_weapon_in_scene = 4
			elif PlayerData.Player_Information.player_current_weapon_number == 5 && PlayerData.Player_Information.player_weapon_in_scene != 5:
				weapon_left_point.add_claymore_to_scene()
				PlayerData.Player_Information.player_weapon_in_scene = 5
			elif PlayerData.Player_Information.player_current_weapon_number == 6 && PlayerData.Player_Information.player_weapon_in_scene != 6:
				weapon_left_point.add_fire_claymore_to_scene()
				PlayerData.Player_Information.player_weapon_in_scene = 6
			elif PlayerData.Player_Information.player_current_weapon_number == 7 && PlayerData.Player_Information.player_weapon_in_scene != 7:
				weapon_left_point.add_warhammer_to_scene()
				PlayerData.Player_Information.player_weapon_in_scene = 7
			elif PlayerData.Player_Information.player_current_weapon_number == 8 && PlayerData.Player_Information.player_weapon_in_scene != 8:
				weapon_left_point.add_earth_warhammer_to_scene()
				PlayerData.Player_Information.player_weapon_in_scene = 8
			elif PlayerData.Player_Information.player_current_weapon_number == 9 && PlayerData.Player_Information.player_weapon_in_scene != 9:
				weapon_right_point.add_straight_bow_to_scene()
				PlayerData.Player_Information.player_weapon_in_scene = 9
			elif PlayerData.Player_Information.player_current_weapon_number == 10 && PlayerData.Player_Information.player_weapon_in_scene != 10:
				weapon_right_point.add_recurve_bow_to_scene()
				PlayerData.Player_Information.player_weapon_in_scene = 10
		else:
			PlayerData.Player_Information.player_current_weapon_number = -1 #0
			PlayerData.Player_Information.player_weapon_in_scene = -1 #0
	if Input.is_action_just_pressed("two"):
		PlayerData.Player_Information.player_current_weapon_slot_number = 2
		if carrying_object == true:
			throw_object()
		if Global_Player.inventory_equiped_items.inventory_weapons2 != -1:
			PlayerData.Player_Information.player_current_weapon_number = Global_Player.inventory_equiped_items.inventory_weapons2
			if PlayerData.Player_Information.player_current_weapon_number == 1 && PlayerData.Player_Information.player_weapon_in_scene != 1:
				weapon_left_point.add_sword_to_scene()
				PlayerData.Player_Information.player_weapon_in_scene = 1
			elif PlayerData.Player_Information.player_current_weapon_number == 2 && PlayerData.Player_Information.player_weapon_in_scene != 2:
				weapon_left_point.add_lightning_sword_to_scene()
				PlayerData.Player_Information.player_weapon_in_scene = 2
			elif PlayerData.Player_Information.player_current_weapon_number == 3 && PlayerData.Player_Information.player_weapon_in_scene != 3:
				weapon_left_point.add_axe_to_scene()
				PlayerData.Player_Information.player_weapon_in_scene = 3
			elif PlayerData.Player_Information.player_current_weapon_number == 4 && PlayerData.Player_Information.player_weapon_in_scene != 4:
				weapon_left_point.add_ice_axe_to_scene()
				PlayerData.Player_Information.player_weapon_in_scene = 4
			elif PlayerData.Player_Information.player_current_weapon_number == 5 && PlayerData.Player_Information.player_weapon_in_scene != 5:
				weapon_left_point.add_claymore_to_scene()
				PlayerData.Player_Information.player_weapon_in_scene = 5
			elif PlayerData.Player_Information.player_current_weapon_number == 6 && PlayerData.Player_Information.player_weapon_in_scene != 6:
				weapon_left_point.add_fire_claymore_to_scene()
				PlayerData.Player_Information.player_weapon_in_scene = 6
			elif PlayerData.Player_Information.player_current_weapon_number == 7 && PlayerData.Player_Information.player_weapon_in_scene != 7:
				weapon_left_point.add_warhammer_to_scene()
				PlayerData.Player_Information.player_weapon_in_scene = 7
			elif PlayerData.Player_Information.player_current_weapon_number == 8 && PlayerData.Player_Information.player_weapon_in_scene != 8:
				weapon_left_point.add_earth_warhammer_to_scene()
				PlayerData.Player_Information.player_weapon_in_scene = 8
			elif PlayerData.Player_Information.player_current_weapon_number == 9 && PlayerData.Player_Information.player_weapon_in_scene != 9:
				weapon_right_point.add_straight_bow_to_scene()
				PlayerData.Player_Information.player_weapon_in_scene = 9
			elif PlayerData.Player_Information.player_current_weapon_number == 10 && PlayerData.Player_Information.player_weapon_in_scene != 10:
				weapon_right_point.add_recurve_bow_to_scene()
				PlayerData.Player_Information.player_weapon_in_scene = 10
		else:
			PlayerData.Player_Information.player_current_weapon_number = -1 #0
			PlayerData.Player_Information.player_weapon_in_scene = -1 #0
	if Input.is_action_just_pressed("three"):
		PlayerData.Player_Information.player_current_weapon_slot_number = 3
		if carrying_object == true:
			throw_object()
		if Global_Player.inventory_equiped_items.inventory_weapons3 != -1:
			PlayerData.Player_Information.player_current_weapon_number = Global_Player.inventory_equiped_items.inventory_weapons3
			if PlayerData.Player_Information.player_current_weapon_number == 1 && PlayerData.Player_Information.player_weapon_in_scene != 1:
				weapon_left_point.add_sword_to_scene()
				PlayerData.Player_Information.player_weapon_in_scene = 1
			elif PlayerData.Player_Information.player_current_weapon_number == 2 && PlayerData.Player_Information.player_weapon_in_scene != 2:
				weapon_left_point.add_lightning_sword_to_scene()
				PlayerData.Player_Information.player_weapon_in_scene = 2
			elif PlayerData.Player_Information.player_current_weapon_number == 3 && PlayerData.Player_Information.player_weapon_in_scene != 3:
				weapon_left_point.add_axe_to_scene()
				PlayerData.Player_Information.player_weapon_in_scene = 3
			elif PlayerData.Player_Information.player_current_weapon_number == 4 && PlayerData.Player_Information.player_weapon_in_scene != 4:
				weapon_left_point.add_ice_axe_to_scene()
				PlayerData.Player_Information.player_weapon_in_scene = 4
			elif PlayerData.Player_Information.player_current_weapon_number == 5 && PlayerData.Player_Information.player_weapon_in_scene != 5:
				weapon_left_point.add_claymore_to_scene()
				PlayerData.Player_Information.player_weapon_in_scene = 5
			elif PlayerData.Player_Information.player_current_weapon_number == 6 && PlayerData.Player_Information.player_weapon_in_scene != 6:
				weapon_left_point.add_fire_claymore_to_scene()
				PlayerData.Player_Information.player_weapon_in_scene = 6
			elif PlayerData.Player_Information.player_current_weapon_number == 7 && PlayerData.Player_Information.player_weapon_in_scene != 7:
				weapon_left_point.add_warhammer_to_scene()
				PlayerData.Player_Information.player_weapon_in_scene = 7
			elif PlayerData.Player_Information.player_current_weapon_number == 8 && PlayerData.Player_Information.player_weapon_in_scene != 8:
				weapon_left_point.add_earth_warhammer_to_scene()
				PlayerData.Player_Information.player_weapon_in_scene = 8
			elif PlayerData.Player_Information.player_current_weapon_number == 9 && PlayerData.Player_Information.player_weapon_in_scene != 9:
				weapon_right_point.add_straight_bow_to_scene()
				PlayerData.Player_Information.player_weapon_in_scene = 9
			elif PlayerData.Player_Information.player_current_weapon_number == 10 && PlayerData.Player_Information.player_weapon_in_scene != 10:
				weapon_right_point.add_recurve_bow_to_scene()
				PlayerData.Player_Information.player_weapon_in_scene = 10
		else:
			PlayerData.Player_Information.player_current_weapon_number = -1 #0
			PlayerData.Player_Information.player_weapon_in_scene = -1 #0
	#check if we need to show any armours
	#moved
	#item quick keys
	if Input.is_action_just_pressed("four"):
		PlayerData.Player_Information.player_current_item_number = Global_Player.inventory_equiped_items.inventory_items1
		if Global_Player.inventory_equiped_items.inventory_items1 != -1:
			if Global_Player.inventory_equiped_items.inventory_items1 == 38 && PlayerData.Player_Information.player_item_in_scene != 38:
				weapon_right_point.add_torch_to_scene()
				PlayerData.Player_Information.player_item_in_scene = 38
			elif Global_Player.inventory_equiped_items.inventory_items1 == 28:
				if Global_Player.inventory_equiped_items.inventory_items1_amount > 0:
					_use_potion_of_strength()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items1_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items1 == 29:
				if Global_Player.inventory_equiped_items.inventory_items1_amount > 0:
					_use_potion_of_speed()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items1_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items1 == 30:
				if Global_Player.inventory_equiped_items.inventory_items1_amount > 0:
					_use_potion_of_fortitude()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items1_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items1 == 31:
				if Global_Player.inventory_equiped_items.inventory_items1_amount > 0:
					_use_potion_of_health_small()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items1_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items1 == 32:
				if Global_Player.inventory_equiped_items.inventory_items1_amount > 0:
					_use_potion_of_health_large()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items1_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items1 == 33:
				if Global_Player.inventory_equiped_items.inventory_items1_amount > 0:
					_use_potion_of_mana_small()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items1_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items1 == 34:
				if Global_Player.inventory_equiped_items.inventory_items1_amount > 0:
					_use_potion_of_mana_large()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items1_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items1 == 35:
				if Global_Player.inventory_equiped_items.inventory_items1_amount > 0:
					_use_tea()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items1_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items1 == 36:
				if Global_Player.inventory_equiped_items.inventory_items1_amount > 0:
					_use_apple_green()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items1_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items1 == 37:
				if Global_Player.inventory_equiped_items.inventory_items1_amount > 0:
					_use_apple_red()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items1_amount -= 1
			if Global_Player.inventory_equiped_items.inventory_items1_amount <= 0:
				inventory_node._assign_item_slot_1(-1, -1)
		else:
			PlayerData.Player_Information.player_item_in_scene = 0
		inventory_node.update_slot1_amount()
	if Input.is_action_just_pressed("five"):
		PlayerData.Player_Information.player_current_item_number = Global_Player.inventory_equiped_items.inventory_items2
		if Global_Player.inventory_equiped_items.inventory_items2 != -1:
			if Global_Player.inventory_equiped_items.inventory_items2 == 38 && PlayerData.Player_Information.player_item_in_scene != 38:
				weapon_right_point.add_torch_to_scene()
				PlayerData.Player_Information.player_item_in_scene = 38
			elif Global_Player.inventory_equiped_items.inventory_items2 == 28:
				if Global_Player.inventory_equiped_items.inventory_items2_amount > 0:
					_use_potion_of_strength()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items2_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items2 == 29:
				if Global_Player.inventory_equiped_items.inventory_items2_amount > 0:
					_use_potion_of_speed()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items2_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items2 == 30:
				if Global_Player.inventory_equiped_items.inventory_items2_amount > 0:
					_use_potion_of_fortitude()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items2_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items2 == 31:
				if Global_Player.inventory_equiped_items.inventory_items2_amount > 0:
					_use_potion_of_health_small()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items2_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items2 == 32:
				if Global_Player.inventory_equiped_items.inventory_items2_amount > 0:
					_use_potion_of_health_large()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items2_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items2 == 33:
				if Global_Player.inventory_equiped_items.inventory_items2_amount > 0:
					_use_potion_of_mana_small()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items2_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items2 == 34:
				if Global_Player.inventory_equiped_items.inventory_items2_amount > 0:
					_use_potion_of_mana_large()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items2_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items2 == 35:
				if Global_Player.inventory_equiped_items.inventory_items2_amount > 0:
					_use_tea()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items2_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items2 == 36:
				if Global_Player.inventory_equiped_items.inventory_items2_amount > 0:
					_use_apple_green()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items2_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items2 == 37:
				if Global_Player.inventory_equiped_items.inventory_items2_amount > 0:
					_use_apple_red()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items2_amount -= 1
			if Global_Player.inventory_equiped_items.inventory_items2_amount <= 0:
				inventory_node._assign_item_slot_2(-1, -1)
		else:
			PlayerData.Player_Information.player_item_in_scene = 0
		inventory_node.update_slot2_amount()
	if Input.is_action_just_pressed("six"):
		PlayerData.Player_Information.player_current_item_number = Global_Player.inventory_equiped_items.inventory_items3
		if Global_Player.inventory_equiped_items.inventory_items3 != -1:
			if Global_Player.inventory_equiped_items.inventory_items3 == 38 && PlayerData.Player_Information.player_item_in_scene != 38:
				weapon_right_point.add_torch_to_scene()
				PlayerData.Player_Information.player_item_in_scene = 38
			elif Global_Player.inventory_equiped_items.inventory_items3 == 28:
				if Global_Player.inventory_equiped_items.inventory_items3_amount > 0:
					_use_potion_of_strength()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items3_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items3 == 29:
				if Global_Player.inventory_equiped_items.inventory_items3_amount > 0:
					_use_potion_of_speed()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items3_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items3 == 30:
				if Global_Player.inventory_equiped_items.inventory_items3_amount > 0:
					_use_potion_of_fortitude()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items3_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items3 == 31:
				if Global_Player.inventory_equiped_items.inventory_items3_amount > 0:
					_use_potion_of_health_small()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items3_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items3 == 32:
				if Global_Player.inventory_equiped_items.inventory_items3_amount > 0:
					_use_potion_of_health_large()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items3_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items3 == 33:
				if Global_Player.inventory_equiped_items.inventory_items3_amount > 0:
					_use_potion_of_mana_small()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items3_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items3 == 34:
				if Global_Player.inventory_equiped_items.inventory_items3_amount > 0:
					_use_potion_of_mana_large()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items3_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items3 == 35:
				if Global_Player.inventory_equiped_items.inventory_items3_amount > 0:
					_use_tea()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items3_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items3 == 36:
				if Global_Player.inventory_equiped_items.inventory_items3_amount > 0:
					_use_apple_green()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items3_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items3 == 37:
				if Global_Player.inventory_equiped_items.inventory_items3_amount > 0:
					_use_apple_red()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items3_amount -= 1
			if Global_Player.inventory_equiped_items.inventory_items3_amount <= 0:
				inventory_node._assign_item_slot_3(-1, -1)
		else:
			PlayerData.Player_Information.player_item_in_scene = 0
		inventory_node.update_slot3_amount()
	if Input.is_action_just_pressed("seven"):
		PlayerData.Player_Information.player_current_item_number = Global_Player.inventory_equiped_items.inventory_items4
		if Global_Player.inventory_equiped_items.inventory_items4 != -1:
			if Global_Player.inventory_equiped_items.inventory_items4 == 38 && PlayerData.Player_Information.player_item_in_scene != 38:
				weapon_right_point.add_torch_to_scene()
				PlayerData.Player_Information.player_item_in_scene = 38
			elif Global_Player.inventory_equiped_items.inventory_items4 == 28:
				if Global_Player.inventory_equiped_items.inventory_items4_amount > 0:
					_use_potion_of_strength()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items4_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items4 == 29:
				if Global_Player.inventory_equiped_items.inventory_items4_amount > 0:
					_use_potion_of_speed()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items4_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items4 == 30:
				if Global_Player.inventory_equiped_items.inventory_items4_amount > 0:
					_use_potion_of_fortitude()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items4_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items4 == 31:
				if Global_Player.inventory_equiped_items.inventory_items4_amount > 0:
					_use_potion_of_health_small()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items4_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items4 == 32:
				if Global_Player.inventory_equiped_items.inventory_items4_amount > 0:
					_use_potion_of_health_large()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items4_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items4 == 33:
				if Global_Player.inventory_equiped_items.inventory_items4_amount > 0:
					_use_potion_of_mana_small()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items4_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items4 == 34:
				if Global_Player.inventory_equiped_items.inventory_items4_amount > 0:
					_use_potion_of_mana_large()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items4_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items4 == 35:
				if Global_Player.inventory_equiped_items.inventory_items4_amount > 0:
					_use_tea()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items4_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items4 == 36:
				if Global_Player.inventory_equiped_items.inventory_items4_amount > 0:
					_use_apple_green()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items4_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items4 == 37:
				if Global_Player.inventory_equiped_items.inventory_items4_amount > 0:
					_use_apple_red()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items4_amount -= 1
			if Global_Player.inventory_equiped_items.inventory_items4_amount <= 0:
				inventory_node._assign_item_slot_4(-1, -1)
		else:
			PlayerData.Player_Information.player_item_in_scene = 0
		inventory_node.update_slot4_amount()
	if Input.is_action_just_pressed("eight"):
		PlayerData.Player_Information.player_current_item_number = Global_Player.inventory_equiped_items.inventory_items5
		if Global_Player.inventory_equiped_items.inventory_items5 != -1:
			if Global_Player.inventory_equiped_items.inventory_items5 == 38 && PlayerData.Player_Information.player_item_in_scene != 38:
				weapon_right_point.add_torch_to_scene()
				PlayerData.Player_Information.player_item_in_scene = 38
			elif Global_Player.inventory_equiped_items.inventory_items5 == 28:
				if Global_Player.inventory_equiped_items.inventory_items5_amount > 0:
					_use_potion_of_strength()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items5_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items5 == 29:
				if Global_Player.inventory_equiped_items.inventory_items5_amount > 0:
					_use_potion_of_speed()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items5_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items5 == 30:
				if Global_Player.inventory_equiped_items.inventory_items5_amount > 0:
					_use_potion_of_fortitude()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items5_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items5 == 31:
				if Global_Player.inventory_equiped_items.inventory_items5_amount > 0:
					_use_potion_of_health_small()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items5_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items5 == 32:
				if Global_Player.inventory_equiped_items.inventory_items5_amount > 0:
					_use_potion_of_health_large()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items5_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items5 == 33:
				if Global_Player.inventory_equiped_items.inventory_items5_amount > 0:
					_use_potion_of_mana_small()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items5_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items5 == 34:
				if Global_Player.inventory_equiped_items.inventory_items5_amount > 0:
					_use_potion_of_mana_large()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items5_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items5 == 35:
				if Global_Player.inventory_equiped_items.inventory_items5_amount > 0:
					_use_tea()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items5_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items5 == 36:
				if Global_Player.inventory_equiped_items.inventory_items5_amount > 0:
					_use_apple_green()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items5_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items5 == 37:
				if Global_Player.inventory_equiped_items.inventory_items5_amount > 0:
					_use_apple_red()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items5_amount -= 1
			if Global_Player.inventory_equiped_items.inventory_items5_amount <= 0:
				inventory_node._assign_item_slot_5(-1, -1)
		else:
			PlayerData.Player_Information.player_item_in_scene = 0
		inventory_node.update_slot5_amount()
	if Input.is_action_just_pressed("nine"):
		PlayerData.Player_Information.player_current_item_number = Global_Player.inventory_equiped_items.inventory_items6
		if Global_Player.inventory_equiped_items.inventory_items6 != -1:
			if Global_Player.inventory_equiped_items.inventory_items6 == 38 && PlayerData.Player_Information.player_item_in_scene != 38:
				weapon_right_point.add_torch_to_scene()
				PlayerData.Player_Information.player_item_in_scene = 38
			elif Global_Player.inventory_equiped_items.inventory_items6 == 28:
				if Global_Player.inventory_equiped_items.inventory_items6_amount > 0:
					_use_potion_of_strength()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items6_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items6 == 29:
				if Global_Player.inventory_equiped_items.inventory_items6_amount > 0:
					_use_potion_of_speed()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items6_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items6 == 30:
				if Global_Player.inventory_equiped_items.inventory_items6_amount > 0:
					_use_potion_of_fortitude()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items6_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items6 == 31:
				if Global_Player.inventory_equiped_items.inventory_items6_amount > 0:
					_use_potion_of_health_small()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items6_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items6 == 32:
				if Global_Player.inventory_equiped_items.inventory_items6_amount > 0:
					_use_potion_of_health_large()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items6_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items6 == 33:
				if Global_Player.inventory_equiped_items.inventory_items6_amount > 0:
					_use_potion_of_mana_small()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items6_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items6 == 34:
				if Global_Player.inventory_equiped_items.inventory_items6_amount > 0:
					_use_potion_of_mana_large()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items6_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items6 == 35:
				if Global_Player.inventory_equiped_items.inventory_items6_amount > 0:
					_use_tea()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items6_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items6 == 36:
				if Global_Player.inventory_equiped_items.inventory_items6_amount > 0:
					_use_apple_green()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items6_amount -= 1
			elif Global_Player.inventory_equiped_items.inventory_items6 == 37:
				if Global_Player.inventory_equiped_items.inventory_items6_amount > 0:
					_use_apple_red()
					PlayerData.Player_Information.player_item_in_scene = 0
					Global_Player.inventory_equiped_items.inventory_items6_amount -= 1
			if Global_Player.inventory_equiped_items.inventory_items6_amount <= 0:
				inventory_node._assign_item_slot_6(-1, -1)
		else:
			PlayerData.Player_Information.player_item_in_scene = 0
		inventory_node.update_slot6_amount()

func _process(delta):
	#check player volume, and use for enemy detection later
#	player_sound_volume = player_sound_stream.get_unit_db() #get_volume_db() #AudioServer.get_bus_volume_db(3) # player_sound_listener.get_bus_volume_db(3)
	player_sound_volume = AudioServer.get_bus_volume_db(3) # player_sound_listener.get_bus_volume_db(3)
	
	#update HUD
	process_UI(delta)
	#check if we need to show any armours, doesn't need to be in process, where to move it??
	if PlayerData.Player_Information.player_current_armour_number == 16:
		chainmail_mesh.show()
	else:
		chainmail_mesh.hide()
	if PlayerData.Player_Information.player_current_armour_number == 17:
		scalemail_mesh.show()
	else:
		scalemail_mesh.hide()
	if PlayerData.Player_Information.player_current_armour_number == 18:
		fullplate_mesh.show()
	else:
		fullplate_mesh.hide()
	
	#how character should be if aiming
	if Input.is_action_pressed("right_mouse"):
		PlayerData.current_player_aiming_style = 1
	else:
		PlayerData.current_player_aiming_style = 0
	
	cam_pitch = $rotation_target/target/Camera._total_pitch
	cam_yaw = $rotation_target/target/Camera._total_yaw
	if PlayerData.current_player_aiming_style == 1:
		spine_angle = (spine_angle_resting*3) + cam_pitch
		set_bone_rot("Spine.Middle", spine_angle)
		skel.transform = aim_pos.transform
	else:
		spine_angle = spine_angle_resting
		set_bone_rot("Spine.Middle", spine_angle)
		skel.transform = non_aim_pos.transform

func _physics_process(delta):
	#---- Character Movement Section ----#
	#main movement section
	camera = get_node("rotation_target/target/Camera").get_global_transform()
	var dir = Vector3()
	var is_moving = false
	#directional inputs
	if(Input.is_action_pressed("move_forward")):
		dir += -camera.basis[2]
		is_moving = true
	if(Input.is_action_pressed("move_backward")):
		dir += camera.basis[2]
		is_moving = true
	if(Input.is_action_pressed("move_left")):
		dir += -camera.basis[0]
		is_moving = true
	if(Input.is_action_pressed("move_right")):
		dir += camera.basis[0]
		is_moving = true
	#character on floor actions
	if is_on_floor():
		#if not defending, defend
		if (Input.is_action_pressed("defend")):
			if carrying_object == true:
				throw_object()
			is_defending = true
		else:
			is_defending = false
		#on floor animation control
		if is_defending == true:
			anim = ANIM_DEFEND
		elif is_defending == false:
			#if on floor and not defending, floor transition is movements
			anim = ANIM_FLOOR
			#jumping, only possible if not defending or already jumping
			is_jumping =  false
			if (Input.is_action_just_pressed("jump")):
				velocity.y = PlayerData.Player_Information.player_jump
				is_jumping = true
				p_jump.play()
			#sprinting, only if not defending and not jumping
			elif Input.is_action_pressed("movement_sprint"):
				is_sprinting = true
			else:
				is_sprinting = false
	#if not on the floor, jumping or falling, play jump animation (placeholder falling anim)
	elif is_jumping == true:
		anim = ANIM_JUMP
	#character direction and velocity
	dir.y = 0
	dir = dir.normalized()
	velocity.y += delta*gravity
	var hv = velocity
	hv.y = 0
	var target = dir
	if attacking == true:
		target *= (PlayerData.Player_Information.player_speed_attack_max + speed_mod)
	elif attacking == false:
		if is_sprinting:
			target *= (PlayerData.Player_Information.player_speed_sprint_max + speed_mod)
		else:
			target *= (PlayerData.Player_Information.player_speed_max + speed_mod)
	var accel
	if dir.dot(hv) > 0:
		if attacking == true:
			accel = PlayerData.Player_Information.player_speed_attack_accel
		elif attacking == false:
			if is_sprinting:
				accel = PlayerData.Player_Information.player_speed_sprint_accel
			else:
				accel = PlayerData.Player_Information.player_speed_accel
	else:
		accel = PlayerData.Player_Information.player_speed_deaccel
	hv = hv.linear_interpolate(target, accel*delta)
	velocity.x = hv.x
	velocity.z = hv.z
	velocity = move_and_slide(velocity, Vector3(0,1,0))
	#character rotation
	if PlayerData.current_player_aiming_style == 0:
		cursor.hide()
		#character rotation, has to be after hv has been sorted out, as used by angle var
		if is_moving:
			var angle = atan2(hv.x, hv.z)
			var char_rot = character.get_rotation()
			char_rot.y = angle
			character.set_rotation(char_rot)
	elif PlayerData.current_player_aiming_style == 1:
		if PlayerData.Options_Data.aiming_cursor_show == 0:
			cursor.show()
		elif PlayerData.Options_Data.aiming_cursor_show == 1:
			cursor.hide()
		var angle = -cam_yaw
		var char_rot = character.get_rotation()
		char_rot.y = deg2rad(angle)
		character.set_rotation(char_rot)
	#---- End of Movement Section ----#
	
	#---- Attack Section ----#
	#magic added
	if (Input.is_action_just_pressed("magic_01")):
		magic_attack()
		magicattackanimplay = true
	elif (Input.is_action_just_pressed("magic_02")):
		pass
	else:
		magicattackanimplay = false
#	#character attack timer, could have used a built in timer node, redo?
	if attack_timer<attack_time:
		attack_timer += 0.06
	if attack_timer>=attack_time:
		attacking = false
		combo = 0
	#HUD info to display about weapons, done here instead of in process_gui as easier and quicker
	if PlayerData.Player_Information.player_current_weapon_number >=0 and PlayerData.Player_Information.player_current_weapon_number <=8:
		if attack_timer >= combo_time and attack_timer < attack_time:
			UI_Status_Label_06.text = "Combo Now"
			combo_indicator_show = true
		else:
			UI_Status_Label_06.text = "   " + str(attack_timer)
			combo_indicator_show = false
	elif PlayerData.Player_Information.player_current_weapon_number == 9 or PlayerData.Player_Information.player_current_weapon_number == 10:
		if attack_timer >= bow_release_time and attack_timer < attack_time:
			UI_Status_Label_06.text = "Bow Release"
			bowreleaseanimplay = true
	else:
		UI_Status_Label_06.text = "   " + str(attack_timer)
	#attack attempt input
	var shoot_attempt = Input.is_action_pressed("left_mouse")
	if (shoot_attempt and not prev_shoot):
		if carrying_object == true:
			throw_object()
		#set to 0 or -1 to make sure unarmed, as slots can be set to -1
		if PlayerData.Player_Information.player_current_weapon_number == 0 or PlayerData.Player_Information.player_current_weapon_number == -1: #unarmed
			if attack_timer >=attack_time:
				if is_on_floor():
					attacking = true
					unarmedcombo1animplay = true
					attack_timer = 0.0
					combo = 1
					_attack_01()
				elif is_jumping == true:
					attacking = true
					jumpunarmedanimplay = true
					attack_timer = 0.0
					_attack_01()
			elif attack_timer >= combo_time and attack_timer < attack_time and combo == 1:
				#doesnt need the isonfloor ifs, as combo number is only set if player is on floor
				#and combo attacks can only be done if there is a combo number other than 0
				attacking = true
				unarmedcombo2animplay = true
				attack_timer = 0.0
				combo = 2
				_attack_02()
			elif attack_timer >= combo_time and attack_timer < attack_time and combo == 2:
				attacking = true
				unarmedcombo3animplay = true
				attack_timer = 0.0
				combo = 3
				_attack_03()
		elif PlayerData.Player_Information.player_current_weapon_number == 1 or PlayerData.Player_Information.player_current_weapon_number == 2 or PlayerData.Player_Information.player_current_weapon_number == 3 or PlayerData.Player_Information.player_current_weapon_number == 4: #sword or axe
			if attack_timer >=attack_time:
				if is_on_floor():
					attacking = true
					onehandedcombo1animplay = true
					attack_timer = 0.0
					combo = 1
					_attack_01()
				elif is_jumping == true:
					attacking = true
					jumponehandedanimplay = true
					attack_timer = 0.0
					_attack_01()
			elif attack_timer >= combo_time and attack_timer < attack_time and combo == 1:
				attacking = true
				onehandedcombo2animplay = true
				attack_timer = 0.0
				combo = 2
				_attack_02()
			elif attack_timer >= combo_time and attack_timer < attack_time and combo == 2:
				attacking = true
				onehandedcombo3animplay = true
				attack_timer = 0.0
				combo = 3
				_attack_03()
		elif PlayerData.Player_Information.player_current_weapon_number == 5 or PlayerData.Player_Information.player_current_weapon_number == 6 or PlayerData.Player_Information.player_current_weapon_number == 7 or PlayerData.Player_Information.player_current_weapon_number == 8:
			if attack_timer >=attack_time:
				if is_on_floor():
					attacking = true
					twohandedcombo1animplay = true
					attack_timer = 0.0
					combo = 1
					_attack_01()
				elif is_jumping == true:
					attacking = true
					jumptwohandedanimplay = true
					attack_timer = 0.0
					_attack_01()
			elif attack_timer >= combo_time and attack_timer < attack_time and combo == 1:
				attacking = true
				twohandedcombo2animplay = true
				attack_timer = 0.0
				combo = 2
				_attack_02()
			elif attack_timer >= combo_time and attack_timer < attack_time and combo == 2:
				attacking = true
				twohandedcombo3animplay = true
				attack_timer = 0.0
				combo = 3
				_attack_03()
		elif PlayerData.Player_Information.player_current_weapon_number == 9 or PlayerData.Player_Information.player_current_weapon_number == 10:
			if Global_Player.normal_arrow_counter > 0:
				if attack_timer >= attack_time:
					#if PlayerData.current_player_aiming_style == 0:
					if is_on_floor():
						attacking = true
						bowdrawanimplay = true
						attack_timer = 0.0
						_attackbow1()
#					elif PlayerData.current_player_aiming_style == 1:
#						attacking = true
#						bowreleaseanimplay = true
#						attack_timer = 0.0
#						_attackbow1()
	else:
		unarmedcombo1animplay = false
		unarmedcombo2animplay = false
		unarmedcombo3animplay = false
		onehandedcombo1animplay = false
		onehandedcombo2animplay = false
		onehandedcombo3animplay = false
		twohandedcombo1animplay = false
		twohandedcombo2animplay = false
		twohandedcombo3animplay = false
		bowdrawanimplay = false
		bowreleaseanimplay = false
		jumpunarmedanimplay = false
		jumponehandedanimplay = false
		jumptwohandedanimplay = false
	prev_shoot = shoot_attempt
	
	#grab objects section###################
	if PlayerData.Player_Information.player_current_weapon_number == 0 or PlayerData.Player_Information.player_current_weapon_number == -1: #unarmed
		if Input.is_action_just_pressed("axe_get"):
			if carrying_object == false:
				check_if_can_grab()
			elif carrying_object == true:
				throw_object()
	
	if carrying_object == true:
		if object_being_carried.object_type == 1:
			object_being_carried.global_transform.origin = grabbed_object_pos.global_transform.origin
		elif object_being_carried.object_type == 2:
			object_being_carried.global_transform.origin = grabbed_object_pos2.global_transform.origin
	
	#---- Character Animation Section ----#
	#could have used more transition nodes instead of blend nodes, as whole values used, rather than blends
	var speed 
	if is_sprinting == true:
		speed = hv.length()/PlayerData.Player_Information.player_speed_sprint_max
	elif is_sprinting == false:
		speed = hv.length()/PlayerData.Player_Information.player_speed_max
	if is_on_floor():
		#movement animations on floor
		if is_sprinting == true:
			get_node("AnimationTreePlayer").transition_node_set_current("WalkOrRun", 1)
		elif is_sprinting == false:
			get_node("AnimationTreePlayer").transition_node_set_current("WalkOrRun", 0)
		get_node("AnimationTreePlayer").blend2_node_set_amount("IdleOrMove", speed)
		#attack animations on floor
		#melee attack animations
		if unarmedcombo1animplay == true:
			get_node("AnimationTreePlayer").transition_node_set_current("WeaponTransition", 0)
			get_node("AnimationTreePlayer").blend3_node_set_amount("UnarmedAttackBlend", -1)
			get_node("AnimationTreePlayer").oneshot_node_start("AttackOneShot")
		elif unarmedcombo2animplay == true:
			get_node("AnimationTreePlayer").transition_node_set_current("WeaponTransition", 0)
			get_node("AnimationTreePlayer").blend3_node_set_amount("UnarmedAttackBlend", 0)
			get_node("AnimationTreePlayer").oneshot_node_start("AttackOneShot")
		elif unarmedcombo3animplay == true:
			get_node("AnimationTreePlayer").transition_node_set_current("WeaponTransition", 0)
			get_node("AnimationTreePlayer").blend3_node_set_amount("UnarmedAttackBlend", 1)
			get_node("AnimationTreePlayer").oneshot_node_start("AttackOneShot")
		if onehandedcombo1animplay == true:
			get_node("AnimationTreePlayer").transition_node_set_current("WeaponTransition", 1)
			get_node("AnimationTreePlayer").blend3_node_set_amount("1HandedAttackBlend", -1)
			get_node("AnimationTreePlayer").oneshot_node_start("AttackOneShot")
		elif onehandedcombo2animplay == true:
			get_node("AnimationTreePlayer").transition_node_set_current("WeaponTransition", 1)
			get_node("AnimationTreePlayer").blend3_node_set_amount("1HandedAttackBlend", 0)
			get_node("AnimationTreePlayer").oneshot_node_start("AttackOneShot")
		elif onehandedcombo3animplay == true:
			get_node("AnimationTreePlayer").transition_node_set_current("WeaponTransition", 1)
			get_node("AnimationTreePlayer").blend3_node_set_amount("1HandedAttackBlend", 1)
			get_node("AnimationTreePlayer").oneshot_node_start("AttackOneShot")
		if twohandedcombo1animplay == true:
			get_node("AnimationTreePlayer").transition_node_set_current("WeaponTransition", 2)
			get_node("AnimationTreePlayer").blend3_node_set_amount("2HandedAttackBlend", -1)
			get_node("AnimationTreePlayer").oneshot_node_start("AttackOneShot")
		elif twohandedcombo2animplay == true:
			get_node("AnimationTreePlayer").transition_node_set_current("WeaponTransition", 2)
			get_node("AnimationTreePlayer").blend3_node_set_amount("2HandedAttackBlend", 0)
			get_node("AnimationTreePlayer").oneshot_node_start("AttackOneShot")
		elif twohandedcombo3animplay == true:
			get_node("AnimationTreePlayer").transition_node_set_current("WeaponTransition", 2)
			get_node("AnimationTreePlayer").blend3_node_set_amount("2HandedAttackBlend", 1)
			get_node("AnimationTreePlayer").oneshot_node_start("AttackOneShot")
		#ranged attack animations
		elif bowdrawanimplay == true:
			get_node("AnimationTreePlayer").transition_node_set_current("WeaponTransition", 3)
			get_node("AnimationTreePlayer").blend2_node_set_amount("BowAttackBlend", 0)
			get_node("AnimationTreePlayer").oneshot_node_start("AttackOneShot")
		elif bowreleaseanimplay == true:
			get_node("AnimationTreePlayer").transition_node_set_current("WeaponTransition", 3)
			get_node("AnimationTreePlayer").blend2_node_set_amount("BowAttackBlend", 1)
			get_node("AnimationTreePlayer").oneshot_node_start("AttackOneShot")
		#magic attack animations
		elif magicattackanimplay == true:
			get_node("AnimationTreePlayer").transition_node_set_current("WeaponTransition", 5)
			get_node("AnimationTreePlayer").blend2_node_set_amount("MagicBlend", 0)
			get_node("AnimationTreePlayer").oneshot_node_start("AttackOneShot")
	#jumping attack animations
	elif is_jumping == true:
		if jumpunarmedanimplay == true:
			get_node("AnimationTreePlayer").transition_node_set_current("WeaponTransition", 4)
			get_node("AnimationTreePlayer").blend3_node_set_amount("JumpAttackBlend", -1)
			get_node("AnimationTreePlayer").oneshot_node_start("AttackOneShot")
		elif jumponehandedanimplay == true:
			get_node("AnimationTreePlayer").transition_node_set_current("WeaponTransition", 4)
			get_node("AnimationTreePlayer").blend3_node_set_amount("JumpAttackBlend", 0)
			get_node("AnimationTreePlayer").oneshot_node_start("AttackOneShot")
		elif jumptwohandedanimplay == true:
			get_node("AnimationTreePlayer").transition_node_set_current("WeaponTransition", 4)
			get_node("AnimationTreePlayer").blend3_node_set_amount("JumpAttackBlend", 1)
			get_node("AnimationTreePlayer").oneshot_node_start("AttackOneShot")
	get_node("AnimationTreePlayer").transition_node_set_current("MoveTransition", anim)

#---- Character Attack Functions ----#
func _attack_01():
	var area = $ArmaturePlayer01/Skeleton/UpperSpineBone/Area#$Area
	var bodies = area.get_overlapping_bodies()
	var damage
	var magic_damage
	var weapon_type # 0=non-magic, 1 = magic
	var first_attack_type
	var second_attack_type
	if PlayerData.Player_Information.player_current_weapon_number == 0 or PlayerData.Player_Information.player_current_weapon_number == -1: #unarmed
		damage = PlayerDataWeapons.unarmed.damage + PlayerData.Player_Information.player_strength + strength_mod
		weapon_type = 0
		first_attack_type = 0
	elif PlayerData.Player_Information.player_current_weapon_number == 1:
		damage = PlayerDataWeapons.sword.damage + PlayerData.Player_Information.player_strength + strength_mod
		weapon_type = 0
		first_attack_type = 0
		p_weapon.play()
	elif PlayerData.Player_Information.player_current_weapon_number == 2:
		damage = PlayerDataWeapons.sword_lightning.damage + PlayerData.Player_Information.player_strength + strength_mod
		magic_damage = PlayerDataWeapons.sword_lightning.lightning_damage
		weapon_type = 1
		first_attack_type = 0
		second_attack_type = 1
		p_weapon.play()
		p_lightning.play()
	elif PlayerData.Player_Information.player_current_weapon_number == 3:
		damage = PlayerDataWeapons.axe.damage + PlayerData.Player_Information.player_strength + strength_mod
		weapon_type = 0
		first_attack_type = 0
		p_weapon.play()
	elif PlayerData.Player_Information.player_current_weapon_number == 4:
		damage = PlayerDataWeapons.axe_ice.damage + PlayerData.Player_Information.player_strength + strength_mod
		magic_damage = PlayerDataWeapons.axe_ice.ice_damage
		weapon_type = 1
		first_attack_type = 0
		second_attack_type = 2
		p_weapon.play()
		p_ice.play()
	elif PlayerData.Player_Information.player_current_weapon_number == 5:
		damage = PlayerDataWeapons.claymore.damage + PlayerData.Player_Information.player_strength + strength_mod
		weapon_type = 0
		first_attack_type = 0
		p_weapon.play()
	elif PlayerData.Player_Information.player_current_weapon_number == 6:
		damage = PlayerDataWeapons.claymore_fire.damage + PlayerData.Player_Information.player_strength + strength_mod
		magic_damage = PlayerDataWeapons.claymore_fire.fire_damage
		weapon_type = 1
		first_attack_type = 0
		second_attack_type = 3
		p_weapon.play()
		p_fire.play()
	elif PlayerData.Player_Information.player_current_weapon_number == 7:
		damage = PlayerDataWeapons.warhammer.damage + PlayerData.Player_Information.player_strength + strength_mod
		weapon_type = 0
		first_attack_type = 0
		p_weapon.play()
	elif PlayerData.Player_Information.player_current_weapon_number == 8:
		damage = PlayerDataWeapons.warhammer_earth.damage + PlayerData.Player_Information.player_strength + strength_mod
		magic_damage = PlayerDataWeapons.warhammer_earth.earth_damage
		weapon_type = 1
		first_attack_type = 0
		second_attack_type = 4
		p_weapon.play()
		p_earth.play()
	for body in bodies:
		if body == self:
			continue
		if body.has_method("_hit"):
			if weapon_type == 0:
				# hit(damage_amount, damage_type, area)
				# types, 0=physical, 1=lightning, 2=ice, 3=fire, 4=earth
				body._hit(damage, first_attack_type, area.global_transform.origin)
			elif weapon_type == 1:
				body._hit(damage, first_attack_type, area.global_transform.origin)
				body._hit(magic_damage, second_attack_type, area.global_transform.origin)

func _attack_02():
	var area = $ArmaturePlayer01/Skeleton/UpperSpineBone/Area#$Area
	var bodies = area.get_overlapping_bodies()
	var damage
	var magic_damage
	var weapon_type # 0=non-magic, 1 = magic
	var first_attack_type
	var second_attack_type
	if PlayerData.Player_Information.player_current_weapon_number == 0 or PlayerData.Player_Information.player_current_weapon_number == -1: #unarmed
		damage = PlayerDataWeapons.unarmed.damage + PlayerData.Player_Information.player_strength + strength_mod + 2
		weapon_type = 0
		first_attack_type = 0
	elif PlayerData.Player_Information.player_current_weapon_number == 1:
		damage = PlayerDataWeapons.sword.damage + PlayerData.Player_Information.player_strength + strength_mod + 2
		weapon_type = 0
		first_attack_type = 0
		p_weapon.play()
	elif PlayerData.Player_Information.player_current_weapon_number == 2:
		damage = PlayerDataWeapons.sword_lightning.damage + PlayerData.Player_Information.player_strength + strength_mod + 2
		magic_damage = PlayerDataWeapons.sword_lightning.lightning_damage + 2
		weapon_type = 1
		first_attack_type = 0
		second_attack_type = 1
		p_weapon.play()
		p_lightning.play()
	elif PlayerData.Player_Information.player_current_weapon_number == 3:
		damage = PlayerDataWeapons.axe.damage + PlayerData.Player_Information.player_strength + strength_mod + 2
		weapon_type = 0
		first_attack_type = 0
		p_weapon.play()
	elif PlayerData.Player_Information.player_current_weapon_number == 4:
		damage = PlayerDataWeapons.axe_ice.damage + PlayerData.Player_Information.player_strength + strength_mod + 2
		magic_damage = PlayerDataWeapons.axe_ice.ice_damage + 2
		weapon_type = 1
		first_attack_type = 0
		second_attack_type = 2
		p_weapon.play()
		p_ice.play()
	elif PlayerData.Player_Information.player_current_weapon_number == 5:
		damage = PlayerDataWeapons.claymore.damage + PlayerData.Player_Information.player_strength + strength_mod + 2
		weapon_type = 0
		first_attack_type = 0
		p_weapon.play()
	elif PlayerData.Player_Information.player_current_weapon_number == 6:
		damage = PlayerDataWeapons.claymore_fire.damage + PlayerData.Player_Information.player_strength + strength_mod + 2
		magic_damage = PlayerDataWeapons.claymore_fire.fire_damage + 2
		weapon_type = 1
		first_attack_type = 0
		second_attack_type = 3
		p_weapon.play()
		p_fire.play()
	elif PlayerData.Player_Information.player_current_weapon_number == 7:
		damage = PlayerDataWeapons.warhammer.damage + PlayerData.Player_Information.player_strength + strength_mod + 2
		weapon_type = 0
		first_attack_type = 0
		p_weapon.play()
	elif PlayerData.Player_Information.player_current_weapon_number == 8:
		damage = PlayerDataWeapons.warhammer_earth.damage + PlayerData.Player_Information.player_strength + strength_mod + 2
		magic_damage = PlayerDataWeapons.warhammer_earth.earth_damage + 2
		weapon_type = 1
		first_attack_type = 0
		second_attack_type = 4
		p_weapon.play()
		p_earth.play()
	for body in bodies:
		if body == self:
			continue
		if body.has_method("_hit"):
			if weapon_type == 0:
				# hit(damage_amount, damage_type, area)
				# types, 0=physical, 1=lightning, 2=ice, 3=fire, 4=earth
				body._hit(damage, first_attack_type, area.global_transform.origin)
			elif weapon_type == 1:
				body._hit(damage, first_attack_type, area.global_transform.origin)
				body._hit(magic_damage, second_attack_type, area.global_transform.origin)

func _attack_03():
	var area = $ArmaturePlayer01/Skeleton/UpperSpineBone/Area#$Area
	var bodies = area.get_overlapping_bodies()
	var damage
	var magic_damage
	var weapon_type # 0=non-magic, 1 = magic
	var first_attack_type
	var second_attack_type
	if PlayerData.Player_Information.player_current_weapon_number == 0 or PlayerData.Player_Information.player_current_weapon_number == -1: #unarmed
		damage = PlayerDataWeapons.unarmed.damage + PlayerData.Player_Information.player_strength + strength_mod + 5
		weapon_type = 0
		first_attack_type = 0
	elif PlayerData.Player_Information.player_current_weapon_number == 1:
		damage = PlayerDataWeapons.sword.damage + PlayerData.Player_Information.player_strength + strength_mod + 5
		weapon_type = 0
		first_attack_type = 0
		p_weapon.play()
	elif PlayerData.Player_Information.player_current_weapon_number == 2:
		damage = PlayerDataWeapons.sword_lightning.damage + PlayerData.Player_Information.player_strength + strength_mod + 5
		magic_damage = PlayerDataWeapons.sword_lightning.lightning_damage + 5
		weapon_type = 1
		first_attack_type = 0
		second_attack_type = 1
		p_weapon.play()
		p_lightning.play()
	elif PlayerData.Player_Information.player_current_weapon_number == 3:
		damage = PlayerDataWeapons.axe.damage + PlayerData.Player_Information.player_strength + strength_mod + 5
		weapon_type = 0
		first_attack_type = 0
		p_weapon.play()
	elif PlayerData.Player_Information.player_current_weapon_number == 4:
		damage = PlayerDataWeapons.axe_ice.damage + PlayerData.Player_Information.player_strength + strength_mod + 5
		magic_damage = PlayerDataWeapons.axe_ice.ice_damage + 5
		weapon_type = 1
		first_attack_type = 0
		second_attack_type = 2
		p_weapon.play()
		p_ice.play()
	elif PlayerData.Player_Information.player_current_weapon_number == 5:
		damage = PlayerDataWeapons.claymore.damage + PlayerData.Player_Information.player_strength + strength_mod + 5
		weapon_type = 0
		first_attack_type = 0
		p_weapon.play()
	elif PlayerData.Player_Information.player_current_weapon_number == 6:
		damage = PlayerDataWeapons.claymore_fire.damage + PlayerData.Player_Information.player_strength + strength_mod + 5
		magic_damage = PlayerDataWeapons.claymore_fire.fire_damage + 5
		weapon_type = 1
		first_attack_type = 0
		second_attack_type = 3
		p_weapon.play()
		p_fire.play()
	elif PlayerData.Player_Information.player_current_weapon_number == 7:
		damage = PlayerDataWeapons.warhammer.damage + PlayerData.Player_Information.player_strength + strength_mod + 5
		weapon_type = 0
		first_attack_type = 0
		p_weapon.play()
	elif PlayerData.Player_Information.player_current_weapon_number == 8:
		damage = PlayerDataWeapons.warhammer_earth.damage + PlayerData.Player_Information.player_strength + strength_mod + 5
		magic_damage = PlayerDataWeapons.warhammer_earth.earth_damage + 5
		weapon_type = 1
		first_attack_type = 0
		second_attack_type = 4
		p_weapon.play()
		p_earth.play()
	for body in bodies:
		if body == self:
			continue
		if body.has_method("_hit"):
			if weapon_type == 0:
				# hit(damage_amount, damage_type, area)
				# types, 0=physical, 1=lightning, 2=ice, 3=fire, 4=earth
				body._hit(damage, first_attack_type, area.global_transform.origin)
			elif weapon_type == 1:
				body._hit(damage, first_attack_type, area.global_transform.origin)
				body._hit(magic_damage, second_attack_type, area.global_transform.origin)

func _attackbow1():
	arrow_timer.start()

func magic_attack():
	magic_timer.start()

#---- Arrow Firing Control ----#
#can move to arrow point??
func fire_arrows(item_id, number_fired, arrows_upgrades): #fire as in shoot, not remove
	var itemID = item_id
	var itemAmount = number_fired
	var itemUpgrade = arrows_upgrades
	inventory_node._on_pickup_acquired(itemID, itemAmount, arrows_upgrades)

func _on_ArrowTimer_timeout():
	arrow_point.fire_weapon()
	fire_arrows(11, -1, 0)
#why 2 functions to fire an arrow? could move inventory_node._on_pickup_acquired(itemID, itemAmount) here instead?

func _on_MagicTimer_timeout():
	if PlayerData.Player_Information.player_mana >= 10:
		if PlayerData.Player_Information.player_current_weapon_number == 2:
			magic_point.lightning_attack_01()
			PlayerData.Player_Information.player_mana -= 10
		elif PlayerData.Player_Information.player_current_weapon_number == 4:
			magic_point.ice_attack_01()
			PlayerData.Player_Information.player_mana -= 10
		elif PlayerData.Player_Information.player_current_weapon_number == 6:
			magic_point.fire_attack_01()
			PlayerData.Player_Information.player_mana -= 10
		elif PlayerData.Player_Information.player_current_weapon_number == 8:
			magic_point.earth_attack_01()
			PlayerData.Player_Information.player_mana -= 10

#---- PICKUPS ----#
func gain_coin(coin_amount):
	var itemAmount = coin_amount
	PlayerData.points_add(10)
	PlayerData.Player_Information.player_coins += itemAmount

func gain_health(health_gained_amount):
	PlayerData.Player_Information.player_health += health_gained_amount
	PlayerData.Player_Information.player_health = clamp(PlayerData.Player_Information.player_health, 0, PlayerData.Player_Information.player_max_health)

func increase_max_health(max_health_increase_gained):
	PlayerData.Player_Information.player_max_health += max_health_increase_gained

func gain_mana(mana_gained_amount):
	PlayerData.Player_Information.player_mana += mana_gained_amount
	PlayerData.Player_Information.player_mana = clamp(PlayerData.Player_Information.player_mana, 0, PlayerData.Player_Information.player_max_mana)

func increase_max_mana(max_mana_increase_gained):
	PlayerData.Player_Information.player_max_mana += max_mana_increase_gained

func pickups_handler(item_id, item_amount, item_upgrades):
	var itemID = item_id
	var itemAmount = item_amount
	var itemUpgrades = item_upgrades
	p_pickup.play()
	inventory_node._on_pickup_acquired(itemID, itemAmount, itemUpgrades)

#---- Player Damage and Reset ----#
func _hit(damage_received, type, hit_position):
#	print ("player was hit")
	#need to add magic resistances to player
	var armour_value
	if PlayerData.Player_Information.player_current_armour_number == 16:
		armour_value = PlayerDataWeapons.chainmail.armour
	elif PlayerData.Player_Information.player_current_armour_number == 17:
		armour_value = PlayerDataWeapons.scalemail.armour
	elif PlayerData.Player_Information.player_current_armour_number == 18:
		armour_value = PlayerDataWeapons.fullplate.armour
	else:
		armour_value = 0
	var shield_value
	if is_defending == true:
		if PlayerData.Player_Information.player_current_shield_number == 39:
			shield_value = PlayerDataWeapons.shields_armour.buckler_defence
		elif PlayerData.Player_Information.player_current_shield_number == 40:
			shield_value = PlayerDataWeapons.shields_armour.small_defence
		elif PlayerData.Player_Information.player_current_shield_number == 41:
			shield_value = PlayerDataWeapons.shields_armour.med_defence
		elif PlayerData.Player_Information.player_current_shield_number == 42:
			shield_value = PlayerDataWeapons.shields_armour.tower_defence
		else:
			shield_value = 0
	else:
		shield_value = 0
	var damage_to_player
	if type == 0: # normal
		damage_to_player = (damage_received - armour_value - shield_value - fort_mod - PlayerData.Player_Information.player_defence)
	elif type == 1: # lightning
		damage_to_player = (damage_received - armour_value - shield_value - fort_mod - PlayerData.Player_Information.player_lightning_affinity)
	elif type == 2: # ice
		damage_to_player = (damage_received - armour_value - shield_value - fort_mod - PlayerData.Player_Information.player_ice_affinity)
	elif type == 3: # fire
		damage_to_player = (damage_received - armour_value - shield_value - fort_mod - PlayerData.Player_Information.player_fire_affinity)
	elif type == 4: # earth
		damage_to_player = (damage_received - armour_value - shield_value - fort_mod - PlayerData.Player_Information.player_earth_affinity)
	#damage_to_player = (damage_received - armour_value - shield_value - fort_mod)
	damage_to_player = clamp(damage_to_player, 0, 500)
	PlayerData.Player_Information.player_health -= damage_to_player
	p_hit.play()
	if PlayerData.Player_Information.player_health <= 0:
		_player_death()

func _player_death():
	if PlayerData.Player_Information.player_lives > 0:
		PlayerData.Player_Information.player_lives -= 1
		_respawn_player()
	elif PlayerData.Player_Information.player_lives <= 0:
		if PlayerData.Player_Information.current_level == 8500:
			get_node("/root/PlayerData").goto_scene("res://Scenes/ArenaScenes/ArenaScoreBoard.tscn")
		else:
			get_node("/root/PlayerData").goto_scene("res://Scenes/MenuScenes/GameOver.tscn")

func _respawn_player():
	PlayerData.Player_Information.player_health = PlayerData.Player_Information.player_max_health
	self.global_transform = respawn_point.global_transform

func _restart_level():
	self.global_transform = respawn_point.global_transform

#items use
#could be integrated into attack control script in physics_process
func _use_potion_of_strength():
	if is_under_effect == false:
		strength_mod = 10
		effects_timer.start()
		is_under_effect = true

func _use_potion_of_speed():
	if is_under_effect == false:
		speed_mod = 3
		effects_timer.start()
		is_under_effect = true

func _use_potion_of_fortitude():
	if is_under_effect == false:
		fort_mod = 5
		effects_timer.start()
		is_under_effect = true

func _use_potion_of_health_small():
	gain_health(25)

func _use_potion_of_health_large():
	gain_health(50)

func _use_potion_of_mana_small():
	gain_mana(25)

func _use_potion_of_mana_large():
	gain_mana(50)

func _use_tea():
	gain_health(50)
	gain_mana(50)
	if is_under_effect == false:
		fort_mod = 5
		effects_timer.start()
		is_under_effect = true

func _use_apple_green():
	gain_health(10)

func _use_apple_red():
	gain_health(10)

func _on_EffectTimer_timeout():
	is_under_effect = false
	strength_mod = 0
	speed_mod = 0
	fort_mod = 0

func track_zombies(posi_x, posi_y):
	map.add_enemy_sprite(posi_x, posi_y)
	pass

func track_allies(posi_x, posi_y):
	map.add_ally_sprite(posi_x, posi_y)
	pass

func check_if_can_grab():
	var grab_area = $ArmaturePlayer01/Skeleton/UpperSpineBone/GrabArea
	var grab_bodies = grab_area.get_overlapping_bodies()
	for grab_body in grab_bodies:
		if grab_body == self:
			continue
		if grab_body is RigidBody:
			if grab_body.has_method("_bump"):
				object_being_carried = grab_body
				object_being_carried.mode = RigidBody.MODE_STATIC
				object_being_carried.grabbed = true
				carrying_object = true

func throw_object():
	var hit_here
	hit_here = grabbed_object_pos.global_transform.origin
	object_being_carried.mode = RigidBody.MODE_RIGID
	object_being_carried.grabbed = false
	object_being_carried._bump(hit_here)
	object_being_carried = null
	carrying_object = false





