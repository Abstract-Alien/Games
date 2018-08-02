extends Area2D
signal hit

export (int) var speed  # How fast player will move
var screensize          # size of the game window
var direction = Vector2()
var tween


func _ready():
	speed = 0
	screensize = get_viewport_rect().size
	tween = get_node("Tween")


func _process(delta):
	var velocity = Vector2()  # Player's movement vector
	
	# Controls (Keyboard and Gamepad)
	if Input.is_action_pressed("ui_right"):  
		velocity.x += 1
	if Input.is_action_pressed("ui_left"): 
		velocity.x -= 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	
	# Touch movement
	velocity +=  direction
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$Trail.emitting = true
		# play animation here if have one
	
	else:
		$Trail.emitting = false
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)


func _on_Player_body_entered(body):
	hide()  # Player disappears after being hit
	emit_signal("hit")
	$CollisionShape2D.disabled = true
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


func set_direction(move):
	direction = move


# Decelerate when not touching the screen
func _on_AnalogStick_released():
	tween.interpolate_property(self, "speed", 200, 0, 0.6, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()
	speed = 0


func _on_AnalogStick_touching():
	#speed = 200
	tween.interpolate_property(self, "speed", 0, 200, .0001, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()

