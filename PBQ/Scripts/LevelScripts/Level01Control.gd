extends Spatial

var castle_portcullis
var port_closed
var port_open
var level_objective_text

func _ready():
	castle_portcullis = $Castle01Main/Castle01Portcullis
	port_closed = $Castle01Main/PortClosedPos
	port_open = $Castle01Main/PortOpenPos
	level_objective_text = $LevelObjective
	castle_portcullis.global_transform = port_closed.global_transform

func _process(delta):
	if PlayerData.Player_Information.spoken_to_castle_mage == false:
		castle_portcullis.global_transform = port_closed.global_transform
	elif PlayerData.Player_Information.spoken_to_castle_mage == true:
		castle_portcullis.global_transform = port_open.global_transform
	
	if PlayerData.Player_Information.spoken_to_castle_mage == false:
		level_objective_text.text = "Speak to the Castle Mage"
	elif PlayerData.Player_Information.spoken_to_castle_mage == true:
		level_objective_text.text = "Leave the Castle"
