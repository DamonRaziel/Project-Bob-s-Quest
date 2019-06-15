extends Spatial

var sword_scene = preload("res://Scenes/PlayerScenes/WeaponScenes/WeaponArmingSword.tscn")
var lightning_sword_scene = preload("res://Scenes/PlayerScenes/WeaponScenes/WeaponLightningSword.tscn")
var axe_scene = preload("res://Scenes/PlayerScenes/WeaponScenes/WeaponAxe.tscn")
var ice_axe_scene = preload("res://Scenes/PlayerScenes/WeaponScenes/WeaponAxeIce.tscn")
var claymore_scene = preload("res://Scenes/PlayerScenes/WeaponScenes/WeaponClaymore.tscn")
var fire_claymore_scene = preload("res://Scenes/PlayerScenes/WeaponScenes/WeaponClaymoreFire.tscn")
var warhammer_scene = preload("res://Scenes/PlayerScenes/WeaponScenes/WeaponWarhammer.tscn")
var earth_warhammer_scene = preload("res://Scenes/PlayerScenes/WeaponScenes/WeaponWarhammerEarth.tscn")
var straight_bow_scene = preload("res://Scenes/PlayerScenes/WeaponScenes/WeaponBowStraight.tscn")
var recurve_bow_scene = preload("res://Scenes/PlayerScenes/WeaponScenes/WeaponBowRecurve.tscn")
var torch_scene = preload("res://Scenes/PlayerScenes/WeaponScenes/ItemTorch.tscn")

var clone

func _ready():
	pass

func add_sword_to_scene():
	clone = sword_scene.instance()
	self.add_child(clone) 
	clone.global_transform = self.global_transform

func add_lightning_sword_to_scene():
	clone = lightning_sword_scene.instance()
	self.add_child(clone) 
	clone.global_transform = self.global_transform

func add_axe_to_scene():
	clone = axe_scene.instance()
	self.add_child(clone) 
	clone.global_transform = self.global_transform

func add_ice_axe_to_scene():
	clone = ice_axe_scene.instance()
	self.add_child(clone) 
	clone.global_transform = self.global_transform

func add_claymore_to_scene():
	clone = claymore_scene.instance()
	self.add_child(clone) 
	clone.global_transform = self.global_transform

func add_fire_claymore_to_scene():
	clone = fire_claymore_scene.instance()
	self.add_child(clone) 
	clone.global_transform = self.global_transform

func add_warhammer_to_scene():
	clone = warhammer_scene.instance()
	self.add_child(clone) 
	clone.global_transform = self.global_transform

func add_earth_warhammer_to_scene():
	clone = earth_warhammer_scene.instance()
	self.add_child(clone) 
	clone.global_transform = self.global_transform

func add_straight_bow_to_scene():
	clone = straight_bow_scene.instance()
	self.add_child(clone)
	clone.global_transform = self.global_transform

func add_recurve_bow_to_scene():
	clone = recurve_bow_scene.instance()
	self.add_child(clone)
	clone.global_transform = self.global_transform

func add_torch_to_scene():
	clone = torch_scene.instance()
	self.add_child(clone)
	clone.global_transform = self.global_transform
