extends Spatial

var waypoints = []
var waypoints_number

func _ready():
	#add children as array points
	waypoints_number = get_child_count()
	print ("number of waypoints = ", waypoints_number)
	waypoints = get_children()
	print ("waypoints are :  ", waypoints)
	#pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

#timer to countdown for selection should be done in enemy scripts, linked to the array gathered here??