extends Spatial

var level_objective_text
var end_of_level
var end_of_level_show
var end_of_level_hide

var end_of_level_alt
var end_of_level_show_alt
var end_of_level_hide_alt

func _ready():
	level_objective_text = $LevelObjective
	end_of_level = $EndOfLevel
	end_of_level_hide = $EndOfLevelHide
	end_of_level_show = $EndOfLevelShow
	end_of_level_alt = $EndOfLevelAlt
	end_of_level_hide_alt = $EndOfLevelHideAlt
	end_of_level_show_alt = $EndOfLevelShowAlt

func _process(delta):
	if PlayerData.Player_Information.beaten_zombie_boss == false:
		end_of_level.global_transform = end_of_level_hide.global_transform
		end_of_level_alt.global_transform = end_of_level_hide_alt.global_transform
		level_objective_text.text = "Defeat the Zombie Knight"
	elif PlayerData.Player_Information.beaten_zombie_boss == true:
		end_of_level.global_transform = end_of_level_show.global_transform
		end_of_level_alt.global_transform = end_of_level_show_alt.global_transform
		level_objective_text.text = "Exit the Cemetery"
