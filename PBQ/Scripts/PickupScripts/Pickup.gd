extends Spatial

export var ITEM_ID = 11
export var ITEM_AMOUNT = 5

func _on_Area_body_entered(body):
	if body.has_method("pickups_handler"):
		Global_Player.check_if_inventory_is_full()
		if PlayerData.Player_Information.player_inventory_is_full == false:
			body.pickups_handler(ITEM_ID, ITEM_AMOUNT)
			queue_free()

