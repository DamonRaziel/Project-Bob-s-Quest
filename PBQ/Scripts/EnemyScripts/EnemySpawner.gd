extends Spatial

var spawn_navmesh
var spawn_target
var spawn_waypoint_numbers_to_choose_from
var spawn_waypoint_number_chosen
var spawn_enemy_waypoints

var zombie_male_spawn = preload("res://Scenes/EnemyScenes/ZombieMaleNavTest.tscn")
var zombie_female_spawn = preload("res://Scenes/EnemyScenes/ZombieFemaleNav.tscn")
var creature_spawn = preload("res://Scenes/EnemyScenes/CreatureNav.tscn")
var creature_quad_spawn = preload("res://Scenes/EnemyScenes/CreatureQuadNav.tscn")
var creature_flying_spawn = preload("res://Scenes/EnemyScenes/CreatureFlyingResizedNav.tscn")

var zombie_knight_spawn = preload("res://Scenes/EnemyScenes/ZombieBossNav.tscn")
var davey_spawn = preload("res://Scenes/EnemyScenes/DaveyJonesBossNav.tscn")
var creature_boss_spawn = preload("res://Scenes/EnemyScenes/CreatureBossNav.tscn")
var sorceror_spawn = preload("res://Scenes/EnemyScenes/SorcerorNav.tscn")

var spawned_choice_number
var spawned_choice
var spawned_clone

func _ready():
	spawn_navmesh = get_parent()
	spawn_enemy_waypoints = spawn_navmesh.get_node("WaypointsHolder").waypoints
	spawn_waypoint_numbers_to_choose_from = spawn_navmesh.get_node("WaypointsHolder").waypoints_number

func spawn_enemy():
	randomize()
	spawn_waypoint_number_chosen = randi()%spawn_waypoint_numbers_to_choose_from
	spawn_target = spawn_enemy_waypoints[spawn_waypoint_number_chosen]
	#print ("spawn point chosen = ", spawn_waypoint_number_chosen)
	spawned_choice_number = randi()%10
	#print ("spawn number chosen = ", spawned_choice_number)
	if spawned_choice_number == 0:
		spawned_clone = zombie_male_spawn.instance()
	elif spawned_choice_number == 1:
		spawned_clone = zombie_female_spawn.instance()
	elif spawned_choice_number == 2:
		spawned_clone = creature_spawn.instance()
	elif spawned_choice_number == 3:
		spawned_clone = creature_quad_spawn.instance()
	elif spawned_choice_number == 4:
		spawned_clone = creature_flying_spawn.instance()
	elif spawned_choice_number == 5:
		spawned_clone = creature_boss_spawn.instance()
	elif spawned_choice_number == 6:
		spawned_clone = zombie_knight_spawn.instance()
	elif spawned_choice_number == 7:
		spawned_clone = davey_spawn.instance()
	elif spawned_choice_number == 8:
		spawned_clone = sorceror_spawn.instance()
	elif spawned_choice_number == 9:
		spawned_clone = zombie_female_spawn.instance()
	elif spawned_choice_number == 10:
		spawned_clone = zombie_male_spawn.instance()
	
	self.add_child(spawned_clone) 
	spawned_clone.global_transform.origin.x = spawn_target.global_transform.origin.x
	spawned_clone.global_transform.origin.z = spawn_target.global_transform.origin.z
