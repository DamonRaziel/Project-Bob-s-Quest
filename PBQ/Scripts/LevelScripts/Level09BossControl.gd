extends Spatial

var level_objective_text
var end_of_level
var end_of_level_show
var end_of_level_hide

func _ready():
	level_objective_text = $LevelObjective
	end_of_level = $EndOfLevel
	end_of_level_hide = $EndOfLevelHide
	end_of_level_show = $EndOfLevelShow

func _process(delta):
	if PlayerData.Player_Information.beaten_sorceror_boss == true && PlayerData.Player_Information.beaten_creature_boss == true:
		end_of_level.global_transform = end_of_level_show.global_transform
		level_objective_text.text = "Exit the Pit"
	else:
		end_of_level.global_transform = end_of_level_hide.global_transform
		level_objective_text.text = "Defeat the Sorceror and Creature"
