extends Spatial

var attack_to_add = preload("res://Scenes/EnemyScenes/CreatureFlyingFireballSingle.tscn")
var damage = -10
var speed = 15
var track_player = false
var track_target = null
var up_thingy = Vector3(0, 1, 0)

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	if track_player == true:
		self.look_at(track_target.global_transform.origin, up_thingy)
	else:
		pass

func attack():
	var clone = attack_to_add.instance()
	var scene_root = get_tree().root.get_children()[0]
	scene_root.add_child(clone)
	clone.global_transform = self.global_transform
	clone.CF_DAMAGE = damage
	clone.CF_SPEED = speed