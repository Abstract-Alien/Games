extends KinematicBody2D

signal shooting
signal not_shooting

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
	### Shoot stick controls
	var touch_position = Vector2()
	
	# Detect a touch on right side of screen
	if event is InputEventScreenTouch && touchID == -1 && event.pressed && event.position.x > screensize.x / 2 && event.position.y > 100:
		#emit_signal("touching")
		show()
		touchID = event.index
		touch_position = event.position
		position = touch_position
		
	# Detect a drag if it is still the same touch
	elif event is InputEventScreenDrag && event.index == touchID:
		emit_signal("shooting")
		stick.position = event.position - position  # offset the stick position
		### Need to figure out how to clamp to a circle instead of rectangle
		stick.position.x = clamp(stick.position.x, -100, 100) 
		stick.position.y = clamp(stick.position.y, -100, 100) 
		
		direction = stick.position - touch_position
		
	# Detect if touch is released
	if event is InputEventScreenTouch && event.index == touchID && !event.pressed:
		hide()
		touchID = -1
		stick.position = Vector2(0, 0)
		direction = Vector2(0, 0)
		emit_signal("not_shooting")


func get_direction():
	return direction
