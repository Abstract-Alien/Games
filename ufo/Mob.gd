extends RigidBody2D

export (int) var min_speed
export (int) var max_speed

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _on_Visibility_screen_exited():
	queue_free()
