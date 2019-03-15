extends Spatial

func _ready():
	set_as_toplevel(true)

func _process(delta):
	self.global_transform = get_parent().get_node("FlameAttachment").global_transform





