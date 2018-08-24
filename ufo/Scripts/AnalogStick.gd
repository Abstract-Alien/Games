#extends KinematicBody2D
extends Node2D

signal touching
signal released

export var direction = Vector2()
var touch_id = -1
var stick
var screensize

onready var ufo = get_tree().get_root().get_node("World/UFO")


func _ready():
	hide()
	stick = $StickBG/Stick
	screensize = get_viewport_rect().size


func _input(event):
	var touch_position = Vector2()
	var deadzone = 0.05

	# Detect Touch
	if event is InputEventScreenTouch && touch_id == -1 && event.pressed && event.position.x < screensize.x / 2:
		show()
		position = event.position
		touch_id = event.index
		touch_position = event.position
		emit_signal("touching")	

	# Detect Drag
	if event is InputEventScreenDrag && touch_id == event.index:
		stick.position = event.position - position

		# Clamp stick.position.length to background circle
		if stick.position.length() != 0:
			stick.position = stick.position.clamped(100)

		direction = stick.position
		if direction != Vector2(0, 0):
			direction.x /= 100
			direction.y /=100

			if direction.length() < deadzone:
				direction = Vector2(0, 0)
			else:
				direction = direction.normalized() * ((direction.length() - deadzone) / (1 - deadzone))
			pass
		
		ufo.set_direction(direction)

	# Detect Release
	if event is InputEventScreenTouch && touch_id == event.index && !event.pressed:
		reset_direction()


func reset_direction():
	hide()
	touch_id = -1
	stick.position = Vector2(0, 0)
	direction = Vector2(0, 0)
	emit_signal("released")


func get_direction():
	return direction




################
#
#extends Node2D
#
## Signals
#signal touching
#signal released
#
## Member Variables
#var direction = Vector2()
#var touch_id = -1
#var stick
#var player
#
#
#func _ready():
#	hide()
#	stick = $Stick_BG/Stick
#	player = get_tree().get_root().get_node("World/UFO")
#	print(player.name)
#
#
#func _input(event):
#	var touch_position = Vector2()
#	var deadzone = 0.05
#
#	# Detect Touch
#	if event is InputEventScreenTouch && touch_id == -1 && event.pressed:
#		show()
#		position = event.position
#		touch_id = event.index
#		touch_position = event.position
#		emit_signal("touching")
#
#	# Detect Drag
#	if event is InputEventScreenDrag && touch_id == event.index:
#		stick.position = event.position - position
#		#print(stick.position.length())
#		#print(stick.position)
#
#		# Clamp stick.position.length to background circle
#		if stick.position.length() != 0:
#			stick.position = stick.position.clamped(100)
#
#		direction = stick.position#stick.position - touch_position
#		if direction != Vector2(0, 0):
#			#direction = direction.normalized()
#			direction.x /= 100
#			direction.y /=100
#
#			### figure out this deadzone scripting
#			if direction.length() < deadzone:
#				direction = Vector2(0, 0)
#			else:
#				direction = direction.normalized() * ((direction.length() - deadzone) / (1 - deadzone))
#			pass
#		#print(direction)
#		player.set_direction(direction)
#
#	# Detect Release
#	if event is InputEventScreenTouch && touch_id == event.index && !event.pressed:
#		hide()
#		touch_id = -1
#		stick.position = Vector2(0, 0)
#		direction = Vector2(0, 0)
#		emit_signal("released")




#### Player
#
#func _physics_process(delta):
#	move_and_slide(direction)
##	if touching:
##		#move_and_collide(direction * delta)
##		move_and_slide(direction)
##	else:
#	if!touching:
#		direction = Vector2(0, 0)
#
#
#func set_direction(direc):
#	direction = direc
#
#	if direction != Vector2(0, 0):
#		#direction = direction.normalized()
#		# normalizing the direction slows the player prevents sudden jumps in movement
#		# normalizing a Vector2 if both values are 0 will throw an error
#		direction.x *= move_speed
#		direction.y *= move_speed