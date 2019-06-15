extends Spatial

var BULLET_SPEED = 70
var BULLET_DAMAGE = 15

func _physics_process(delta):
	var forward_dir = global_transform.basis.z.normalized()
	global_translate(forward_dir * BULLET_SPEED * delta)

func _on_Area_body_entered(body):
	if body.has_method("_hit"):
		body._hit(BULLET_DAMAGE, 0, self.global_transform.origin)
		queue_free()

func _on_Timer_timeout():
	queue_free()
