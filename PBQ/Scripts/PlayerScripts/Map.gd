extends Control

var player
var player_sprite
var enemy_sprite = preload("res://Scenes/PlayerScenes/EnemySprite.tscn")
var ally_sprite = preload("res://Scenes/PlayerScenes/AllySprite.tscn")
var ecparent

func _ready():
	player = get_parent().get_parent().get_parent().get_parent().get_parent().get_parent() #easier way?
	player_sprite = $PlayerSprite
	player_sprite.position.x = player.get_global_transform().origin.x
	player_sprite.position.y = player.get_global_transform().origin.z
	ecparent = self 

func _process(delta):
	player_sprite.position.x = player.get_global_transform().origin.x
	player_sprite.position.y = player.get_global_transform().origin.z

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
