extends Spatial

var buckler_scene = preload("res://Scenes/PlayerScenes/WeaponScenes/ShieldBuckler.tscn")
var small_scene = preload("res://Scenes/PlayerScenes/WeaponScenes/ShieldSmall.tscn")
var medium_scene = preload("res://Scenes/PlayerScenes/WeaponScenes/ShieldMedium.tscn")
var tower_scene = preload("res://Scenes/PlayerScenes/WeaponScenes/ShieldTower.tscn")

var shield_clone

var shield_number

func _ready():
	pass

func add_buckler_to_scene():
	shield_clone = buckler_scene.instance()
	self.add_child(shield_clone) 
	shield_clone.global_transform = self.global_transform

func add_small_to_scene():
	shield_clone = small_scene.instance()
	self.add_child(shield_clone) 
	shield_clone.global_transform = self.global_transform

func add_medium_to_scene():
	shield_clone = medium_scene.instance()
	self.add_child(shield_clone) 
	shield_clone.global_transform = self.global_transform

func add_tower_to_scene():
	shield_clone = tower_scene.instance()
	self.add_child(shield_clone) 
	shield_clone.global_transform = self.global_transform

func _process(delta):
	#for keeping track of the current weapon 
	#for destruction purposes later
	shield_number = PlayerData.Player_Information.player_current_shield_number
