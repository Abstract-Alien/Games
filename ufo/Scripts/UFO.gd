extends KinematicBody2D


var direction = Vector2(0, 0)
export (int) var move_speed

onready var moving = false
onready var tween = get_node("Tween")


func _physics_process(delta):
	direction = move_and_slide(direction)	
	lean(direction.x / 2)

	if !moving:
		tween.interpolate_property(self, "direction", direction, Vector2(0, 0), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.start()


func lean(direc):
	tween.interpolate_property(self, "rotation", 0, direc, 20, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
	rotation = clamp(rotation, -0.01, 0.01)


func set_direction(direc):
	direction = direc

	if direction != Vector2(0, 0):
		direction.x *= move_speed
		direction.y *= move_speed


func _on_Move_Stick_released():
	moving = false


func _on_Move_Stick_touching():
	moving = true

