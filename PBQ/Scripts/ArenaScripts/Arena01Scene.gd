extends Spatial

onready var spawn_timer1 = $SpawnTimer1
onready var spawn_timer2 = $SpawnTimer2
onready var spawn_timer3 = $SpawnTimer3

onready var wave_label = $ArenaHUD/WaveCounterLabel
onready var wave_countdown = $ArenaHUD/WaveCountDownLabel

var wave = 0

onready var enemy_spawner = $ArenaNav/EnemyHolder

onready var drop_timer = $DropTimer
onready var drop_spawner = $ArenaNav/EquipmentDropper

func _ready():
	spawn_timer1.start()
	drop_timer.start()

func _process(delta):
	wave_label.text = "Waves : " + str(wave)
	if wave <= 5:
		wave_countdown.text = str(spawn_timer1.time_left)
	elif wave > 5 and wave <= 10:
		wave_countdown.text = str(spawn_timer2.time_left)
	elif wave > 10:
		wave_countdown.text = str(spawn_timer3.time_left)

func _on_SpawnTimer1_timeout():
	if wave <= 5:
		spawn_timer1.start()
	else:
		spawn_timer2.start()
	wave += 1
	enemy_spawner.spawn_enemy()
	enemy_spawner.spawn_enemy()
	enemy_spawner.spawn_enemy()

func _on_SpawnTimer2_timeout():
	if wave <= 10:
		spawn_timer2.start()
	else:
		spawn_timer3.start()
	wave += 1
	enemy_spawner.spawn_enemy()
	enemy_spawner.spawn_enemy()
	enemy_spawner.spawn_enemy()
	enemy_spawner.spawn_enemy()

func _on_SpawnTimer3_timeout():
	if wave <= 15:
		spawn_timer3.start()
	wave += 1
	enemy_spawner.spawn_enemy()
	enemy_spawner.spawn_enemy()
	enemy_spawner.spawn_enemy()
	enemy_spawner.spawn_enemy()
	enemy_spawner.spawn_enemy()

func _on_DropTimer_timeout():
	drop_timer.start()
	if PlayerData.arena_setup.drop_rate == 1:
		drop_spawner.spawn_drop()
	if PlayerData.arena_setup.drop_rate == 2:
		drop_spawner.spawn_drop()
		drop_spawner.spawn_drop()
		drop_spawner.spawn_drop()
	if PlayerData.arena_setup.drop_rate == 3:
		drop_spawner.spawn_drop()
		drop_spawner.spawn_drop()
		drop_spawner.spawn_drop()
		drop_spawner.spawn_drop()
		drop_spawner.spawn_drop()
