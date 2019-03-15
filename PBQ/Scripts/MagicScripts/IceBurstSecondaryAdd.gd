extends Spatial

var secondary_ice_burst = preload("res://Scenes/MagicScenes/IceBurstSecondary.tscn")

func _ready():
	pass

func _on_Timer2_timeout():
	var clone = secondary_ice_burst.instance()
	var scene_root = get_tree().root.get_children()[0]
	scene_root.add_child(clone)
	clone.global_transform = self.global_transform
	clone.L_DAMAGE = PlayerDataWeapons.ice_01.magic_damage
	clone.L_SPEED = PlayerDataWeapons.ice_01.magic_speed