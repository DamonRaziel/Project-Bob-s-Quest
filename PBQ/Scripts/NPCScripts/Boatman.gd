extends KinematicBody

onready var interaction_zone = $InteractionArea
onready var level_text = get_parent().get_parent().get_node("LevelText")
var player_is_near = false
var talking_to_player = false
onready var track_timer = $AllyTrackerTimer

func _process(delta):
	if player_is_near == true:
		if(Input.is_action_just_pressed("interaction_button")):
			talking_to_player = true
			PlayerData.Player_Information.spoken_to_boatman = true
		if talking_to_player == false:
			level_text.text = "T - Talk to the Boatman"
		elif talking_to_player == true:
			level_text.text = "I can help you, if you help me. Defeat Davey Jones."

func _on_InteractionArea_body_entered(body):
	if body.has_method("process_UI"):
		player_is_near = true

func _on_InteractionArea_body_exited(body):
	if body.has_method("process_UI"):
		player_is_near = false
		level_text.text = ""

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

func _on_AllyTrackerTimer_timeout():
	ally_tracker()
	track_timer.start()
