extends Node

var track_to_play = 1
onready var track1 = get_node("AudioStreamHYR")
onready var track2 = get_node("AudioStreamFO")
onready var track3 = get_node("AudioStreamC")
onready var track4 = get_node("AudioStreamCotS")

func _ready():
	music_selector()

func music_selector():
	randomize()
	track_to_play = randi()%4+1
	if track_to_play == 1:
		track1.play()
	elif track_to_play == 2:
		track2.play()
	elif track_to_play == 3:
		track3.play()
	elif track_to_play == 4:
		track4.play()
	print(track_to_play)

func _on_AudioStreamHYR_finished():
	music_selector()

func _on_AudioStreamFO_finished():
	music_selector()

func _on_AudioStreamC_finished():
	music_selector()

func _on_AudioStreamCotS_finished():
	music_selector()
