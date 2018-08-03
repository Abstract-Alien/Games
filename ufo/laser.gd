extends RigidBody2D


signal damaged

export (int) var speed
var direction

func _ready():
	pass




func set_direction(dir):
	direction = dir



func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Laser_body_entered(body):
	emit_signal("damaged")
	body.queue_free()
	self.queue_free()