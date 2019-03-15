extends Spatial

var player_node = null
export var this_shield_number = 3

func _ready():
	pass

func _process(delta):
	if PlayerData.Player_Information.player_current_shield_number != this_shield_number:
		destroy_thyself()

func destroy_thyself():
	queue_free()
