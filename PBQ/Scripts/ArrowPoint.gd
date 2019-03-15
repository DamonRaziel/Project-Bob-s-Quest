extends Spatial

var bullet_scene = preload("res://Scenes/ArrowNormal.tscn")
var player_node = null

func _ready():
	pass

func fire_weapon():
	var clone = bullet_scene.instance()
	var scene_root = get_tree().root.get_children()[0]
	scene_root.add_child(clone)
	clone.global_transform = self.global_transform
	clone.BULLET_DAMAGE = PlayerDataWeapons.bow.damage
	clone.BULLET_SPEED = PlayerDataWeapons.bow.arrowspeed