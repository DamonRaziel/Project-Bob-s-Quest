extends Spatial

var level_objective_text

func _ready():
	level_objective_text = $LevelObjective

func _process(delta):
	if PlayerData.Player_Information.spoken_to_guard01 == false:
		level_objective_text.text = "Speak to the Town Guard"
	elif PlayerData.Player_Information.spoken_to_guard01 == true:
		level_objective_text.text = "Make your way to the Cemetery"
