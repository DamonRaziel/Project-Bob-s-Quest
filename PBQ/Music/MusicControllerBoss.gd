extends Node

var boss_track_to_play = 1
onready var boss_track1 = get_node("AudioStreamA")
onready var boss_track2 = get_node("AudioStreamBS")
onready var boss_track3 = get_node("AudioStreamOtF")

func _ready():
	music_selector()

func music_selector():
	randomize()
	boss_track_to_play = randi()%3+1
	if boss_track_to_play == 1:
		boss_track1.play()
	elif boss_track_to_play == 2:
		boss_track2.play()
	elif boss_track_to_play == 3:
		boss_track3.play()
	print(boss_track_to_play)

func _on_AudioStreamA_finished():
	music_selector()

func _on_AudioStreamBS_finished():
	music_selector()

func _on_AudioStreamOtF_finished():
	music_selector()
