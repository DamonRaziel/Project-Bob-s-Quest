extends Spatial

var L_SPEED = 70
var L_DAMAGE = 15
const KILL_TIMER = 4
var timer = 0
var hit_something = false
var secondary_burst = preload("res://Scenes/MagicScenes/IceBurst.tscn")

func _ready():
	$Area.connect("body_entered", self, "collided")

func _physics_process(delta):
	var forward_dir = global_transform.basis.z.normalized()
	global_translate(forward_dir * L_SPEED * delta)
	timer += delta
	if timer >= KILL_TIMER:
		queue_free()

func collided(body):
	if hit_something == false:
		if body.has_method("_hit"):
			body._hit(L_DAMAGE, 2, self.global_transform.origin)
		var clone = secondary_burst.instance()
		var scene_root = get_tree().root.get_children()[0]
		scene_root.add_child(clone)
		clone.global_transform = self.global_transform
	hit_something = true
	queue_free()