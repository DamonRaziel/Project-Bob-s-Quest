extends Spatial

export var ITEM_ID = 11
export var ITEM_AMOUNT = 5
var hit_something = false

func _ready():
	$Area.connect("body_entered", self, "collided")

func collided(body):
	if hit_something == false:
		if body.has_method("pickups_handler"):
			Global_Player.check_if_inventory_is_full()
			if PlayerData.Player_Information.player_inventory_is_full ==  false:
				body.pickups_handler(ITEM_ID, ITEM_AMOUNT)
				hit_something = true
				queue_free()
