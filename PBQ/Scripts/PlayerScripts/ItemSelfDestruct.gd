extends Spatial

var item_player_node = null
export var this_item_number = 3

func _process(delta):
	if PlayerData.Player_Information.player_current_item_number != this_item_number:
		destroy_thyself()

func destroy_thyself():
	queue_free()

