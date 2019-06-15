extends Spatial

var CF_SPEED = 10
var CF_DAMAGE = 10
const KILL_TIMER = 4
var timer = 0
var hit_something = false
var fireball_engulf = preload("res://Scenes/EnemyScenes/CreatureFlyingFireballEngulf.tscn")

func _ready():
	$Area.connect("body_entered", self, "collided")

func _physics_process(delta):
	var forward_dir = global_transform.basis.z.normalized()
	global_translate(-forward_dir * CF_SPEED * delta)
	timer += delta
	if timer >= KILL_TIMER:
		queue_free()

func collided(body):
	if hit_something == false:
		var clone = fireball_engulf.instance()
		var scene_root = get_tree().root.get_children()[0]
		scene_root.add_child(clone)
		clone.global_transform = self.global_transform
		#print("hit something")
		if body.has_method("_hit"):
			body._hit(CF_DAMAGE, 3, self.global_transform.origin)
	hit_something = true
	queue_free()