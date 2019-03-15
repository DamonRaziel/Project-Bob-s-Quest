extends Spatial

var player_node = null
export var this_weapon_number = 3

func _ready():
	pass

func _process(delta):
	if PlayerData.Player_Information.player_current_weapon_number != this_weapon_number:
		destroy_thyself()

func destroy_thyself():
	queue_free()
