extends Spatial

var level_objective_text

func _ready():
	level_objective_text = $LevelObjective

func _process(delta):
	if PlayerData.Player_Information.spoken_to_guard02 == false:
		level_objective_text.text = "Talk to the Citadel Mage"
	elif PlayerData.Player_Information.spoken_to_guard02 == true:
		level_objective_text.text = "Go to the Docks"
