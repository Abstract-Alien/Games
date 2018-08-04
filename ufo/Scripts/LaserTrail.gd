extends Line2D

var point
var target
export (NodePath) var target_path
export var trail_length = 0


func _ready():
	target = get_node(target_path)


func _process(delta):
	
	global_position = Vector2(0, 0)
	global_rotation = 0
	point = target.global_position
	add_point(point)
	
	while get_point_count() > trail_length:
		remove_point(0)



#func _on_VisibilityTimer_timeout():
#	visible = true

