extends Control

var player
var player_sprite
var enemy_sprite = preload("res://Scenes/PlayerScenes/EnemySprite.tscn")
var ally_sprite = preload("res://Scenes/PlayerScenes/AllySprite.tscn")
var ecparent

onready var map_player_timer = $MapTimer

func _ready():
	player = get_parent().get_parent().get_parent().get_parent().get_parent().get_parent() #easier way?
	player_sprite = $Camera2D 
	player_sprite.position.x = player.get_global_transform().origin.x
	player_sprite.position.y = player.get_global_transform().origin.z
	ecparent = self 
	map_player_timer.start()

func add_enemy_sprite(enemy_x, enemy_y):
	var enemy_sprite_clone = enemy_sprite.instance()
	var enemy_sprite_parent = ecparent
	enemy_sprite_parent.add_child(enemy_sprite_clone)
	enemy_sprite_clone.position.x = enemy_x
	enemy_sprite_clone.position.y = enemy_y

func add_ally_sprite(ally_x, ally_y):
	var ally_sprite_clone = ally_sprite.instance()
	var ally_sprite_parent = ecparent
	ally_sprite_parent.add_child(ally_sprite_clone)
	ally_sprite_clone.position.x = ally_x
	ally_sprite_clone.position.y = ally_y

func _on_MapTimer_timeout():
	player_sprite.position.x = player.get_global_transform().origin.x
	player_sprite.position.y = player.get_global_transform().origin.z
	map_player_timer.start()
