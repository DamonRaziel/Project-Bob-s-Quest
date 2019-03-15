extends KinematicBody

var interaction_zone
var level_text
var player_is_near = false
var talking_to_player = false

func _ready():
	interaction_zone = $InteractionArea
	level_text = get_parent().get_parent().get_node("LevelText")

func _process(delta):
	ally_tracker()
	if player_is_near == true:
		if(Input.is_action_just_pressed("interaction_button")):
			talking_to_player = true
			PlayerData.Player_Information.spoken_to_citadel_mage = true
	if player_is_near == true:
		if talking_to_player == false:
			level_text.text = "T - Talk to Citadel Mage"
		elif talking_to_player == true:
			level_text.text = "The upper levels are safe. Check the LightHouse. /T-cont."
	else:
		level_text.text = ""

func _on_InteractionArea_body_entered(body):
	if body.has_method("process_UI"):
		player_is_near = true

func _on_InteractionArea_body_exited(body):
	if body.has_method("process_UI"):
		player_is_near = false

func ally_tracker():
	var map_area = $Map_Area
	var bodies_map = map_area.get_overlapping_bodies()
	var pos_x = self.global_transform.origin.x
	var pos_y = self.global_transform.origin.z
	for body in bodies_map:
		if body == self:
			continue
		if body.has_method("track_allies"):
			body.track_allies(pos_x, pos_y)
