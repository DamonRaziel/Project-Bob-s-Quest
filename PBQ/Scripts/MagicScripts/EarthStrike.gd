extends Spatial

var L_SPEED = 70
var L_DAMAGE = 15
const KILL_TIMER = 4
var timer = 0
var hit_something = false

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
			body._hit(L_DAMAGE, 4, self.global_transform.origin)
	hit_something = true
	queue_free()