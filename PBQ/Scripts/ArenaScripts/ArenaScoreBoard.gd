extends Spatial

var temp_score # =playerdata.playerinfo.player_points
var temp_name

var arena_score1
var arena_score2
var arena_score3
var arena_score4
var arena_score5

var arena_score1_char
var arena_score2_char
var arena_score3_char
var arena_score4_char
var arena_score5_char

var new_rank1_rect
var new_rank2_rect
var new_rank3_rect
var new_rank4_rect
var new_rank5_rect

var rank1_score_label
var rank2_score_label
var rank3_score_label
var rank4_score_label
var rank5_score_label

var rank1_char_label
var rank2_char_label
var rank3_char_label
var rank4_char_label
var rank5_char_label

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	new_rank1_rect = $ScoreBoard/BoardControl/RankTitle/BGTextureRank1
	new_rank2_rect = $ScoreBoard/BoardControl/RankTitle/BGTextureRank2
	new_rank3_rect = $ScoreBoard/BoardControl/RankTitle/BGTextureRank3
	new_rank4_rect = $ScoreBoard/BoardControl/RankTitle/BGTextureRank4
	new_rank5_rect = $ScoreBoard/BoardControl/RankTitle/BGTextureRank5
	
	rank1_score_label = $ScoreBoard/BoardControl/ScoreTitle/Score1
	rank2_score_label = $ScoreBoard/BoardControl/ScoreTitle/Score2
	rank3_score_label = $ScoreBoard/BoardControl/ScoreTitle/Score3
	rank4_score_label = $ScoreBoard/BoardControl/ScoreTitle/Score4
	rank5_score_label = $ScoreBoard/BoardControl/ScoreTitle/Score5
	
	rank1_char_label = $ScoreBoard/BoardControl/CharTitle/Char1
	rank2_char_label = $ScoreBoard/BoardControl/CharTitle/Char2
	rank3_char_label = $ScoreBoard/BoardControl/CharTitle/Char3
	rank4_char_label = $ScoreBoard/BoardControl/CharTitle/Char4
	rank5_char_label = $ScoreBoard/BoardControl/CharTitle/Char5
	
	#load scores from playerdata
	arena_score1 = PlayerData.arena_scores.score1
	arena_score1_char = PlayerData.arena_scores.score1char
	arena_score2 = PlayerData.arena_scores.score2
	arena_score2_char = PlayerData.arena_scores.score2char
	arena_score3 = PlayerData.arena_scores.score3
	arena_score3_char = PlayerData.arena_scores.score3char
	arena_score4 = PlayerData.arena_scores.score4
	arena_score4_char = PlayerData.arena_scores.score4char
	arena_score5 = PlayerData.arena_scores.score5
	arena_score5_char = PlayerData.arena_scores.score5char
	
	#player new score to compare
	temp_score = PlayerData.Player_Information.player_points
	temp_name =  PlayerData.Player_Information.player_name
	compare_score(temp_score, temp_name)

func _process(delta):
#	arena_score1 = PlayerData.arena_scores.score1
#	arena_score1_char = PlayerData.arena_scores.score1char
#	arena_score2 = PlayerData.arena_scores.score2
#	arena_score2_char = PlayerData.arena_scores.score2char
#	arena_score3 = PlayerData.arena_scores.score3
#	arena_score3_char = PlayerData.arena_scores.score3char
#	arena_score4 = PlayerData.arena_scores.score4
#	arena_score4_char = PlayerData.arena_scores.score4char
#	arena_score5 = PlayerData.arena_scores.score5
#	arena_score5_char = PlayerData.arena_scores.score5char
	
	#always display current scores
	rank1_score_label.text = str(arena_score1)
	rank1_char_label.text = arena_score1_char
	rank2_score_label.text = str(arena_score2)
	rank2_char_label.text = arena_score2_char
	rank3_score_label.text = str(arena_score3)
	rank3_char_label.text = arena_score3_char
	rank4_score_label.text = str(arena_score4)
	rank4_char_label.text = arena_score4_char
	rank5_score_label.text = str(arena_score5)
	rank5_char_label.text = arena_score5_char

func compare_score(new_score, new_name):
	if new_score >= PlayerData.arena_scores.score1:
		#bump all old scores down in order
		arena_score5 = arena_score4
		arena_score5_char = arena_score4_char
		arena_score4 = arena_score3
		arena_score4_char = arena_score3_char
		arena_score3 = arena_score2
		arena_score3_char = arena_score2_char
		arena_score2 = arena_score1
		arena_score2_char = arena_score1_char
		#add new score
		arena_score1 = new_score
		arena_score1_char = new_name
		#highlight
		new_rank1_rect.show()
		#stop bumping to prevent overwriting all scores
		#pass
	elif new_score >= PlayerData.arena_scores.score2:
		arena_score5 = arena_score4
		arena_score5_char = arena_score4_char
		arena_score4 = arena_score3
		arena_score4_char = arena_score3_char
		arena_score3 = arena_score2
		arena_score3_char = arena_score2_char
		#arena_score2 = arena_score1
		#arena_score2_char = arena_score1_char
		#add new score
		arena_score2 = new_score
		arena_score2_char = new_name
		#highlight
		new_rank2_rect.show()
		#stop bumping to prevent overwriting all scores
		#pass
	elif new_score >= PlayerData.arena_scores.score3:
		arena_score5 = arena_score4
		arena_score5_char = arena_score4_char
		arena_score4 = arena_score3
		arena_score4_char = arena_score3_char
		#arena_score3 = arena_score2
		#arena_score3_char = arena_score2_char
		#arena_score2 = arena_score1
		#arena_score2_char = arena_score1_char
		#add new score
		arena_score3 = new_score
		arena_score3_char = new_name
		#highlight
		new_rank3_rect.show()
		#stop bumping to prevent overwriting all scores
		#pass
	elif new_score >= PlayerData.arena_scores.score4:
		arena_score5 = arena_score4
		arena_score5_char = arena_score4_char
		#arena_score4 = arena_score3
		#arena_score4_char = arena_score3_char
		#arena_score3 = arena_score2
		#arena_score3_char = arena_score2_char
		#arena_score2 = arena_score1
		#arena_score2_char = arena_score1_char
		#add new score
		arena_score4 = new_score
		arena_score4_char = new_name
		#highlight
		new_rank4_rect.show()
		#stop bumping to prevent overwriting all scores
		#pass
	elif new_score >= PlayerData.arena_scores.score5:
		#arena_score5 = arena_score4
		#arena_score5_char = arena_score4_char
		#arena_score4 = arena_score3
		#arena_score4_char = arena_score3_char
		#arena_score3 = arena_score2
		#arena_score3_char = arena_score2_char
		#arena_score2 = arena_score1
		#arena_score2_char = arena_score1_char
		#add new score
		arena_score5 = new_score
		arena_score5_char = new_name
		#highlight
		new_rank5_rect.show()
		#stop bumping to prevent overwriting all scores
		#pass
	#set playerdata.arena_scores to match scores here, then save
	PlayerData.arena_scores.score1 = arena_score1
	PlayerData.arena_scores.score1char = arena_score1_char
	PlayerData.arena_scores.score2 = arena_score2
	PlayerData.arena_scores.score2char = arena_score2_char
	PlayerData.arena_scores.score3 = arena_score3
	PlayerData.arena_scores.score3char = arena_score3_char
	PlayerData.arena_scores.score4 = arena_score4
	PlayerData.arena_scores.score4char = arena_score4_char
	PlayerData.arena_scores.score5 = arena_score5
	PlayerData.arena_scores.score5char = arena_score5_char
	Global_Player.save_arena_scores()
	

func _on_ToMainMenuButton_pressed():
	#Global_Player.save_arena_scores()
	get_node("/root/PlayerData").goto_scene("res://Scenes/MenuScenes/MainMenu.tscn")
