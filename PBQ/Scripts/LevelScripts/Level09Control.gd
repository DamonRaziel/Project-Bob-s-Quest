extends Spatial

var level_objective_text

func _ready():
	level_objective_text = $LevelObjective

func _process(delta):
	level_objective_text.text = "Find the Sorceror"



