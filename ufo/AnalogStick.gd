extends KinematicBody2D

signal touching
signal released

export var direction = Vector2()
var touchID = -1
var stick
var screensize

func _ready():
	hide()
	stick = $StickBG/Stick
	screensize = get_viewport_rect().size
	#set_process_input(true)


func _input(event):
	### Move stick controls
	var touch_position = Vector2()
	
	# Detect a touch and start movement if on left side of screen
	if event is InputEventScreenTouch && touchID == -1 && event.pressed && event.position.x < screensize.x / 2:
		#emit_signal("touching")
		show()
		touchID = event.index
		touch_position = event.position
		position = touch_position
		
	# Detect a drag if it is still the same touch
	elif event is InputEventScreenDrag && event.index == touchID:
		emit_signal("touching")
		stick.position = event.position - position  # offset the stick position
		direction = stick.position - touch_position
		
	# Detect if touch is released
	if event is InputEventScreenTouch && event.index == touchID && !event.pressed:
		hide()
		touchID = -1
		stick.position = Vector2(0, 0)
		direction = Vector2(0, 0)
		emit_signal("released")


func get_direction():
	return direction
