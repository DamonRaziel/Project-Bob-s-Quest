extends Spatial

export var this_weapon_number = 3

onready var timer = $Timer

func _ready():
	timer.start()

func destroy_thyself():
	queue_free()

func _on_Timer_timeout():
	check_item()

func check_item():
	#check every half a second, if no longer this, destroy, if still this, restart timer
	if PlayerData.Player_Information.player_current_weapon_number != this_weapon_number:
		destroy_thyself()
	else:
		timer.start()