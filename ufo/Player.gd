extends Area2D
signal hit

export (int) var speed  # How fast player will move
var screensize          # size of the game window

func _ready():
	screensize = get_viewport_rect().size
	
func _process(delta):
	var velocity = Vector2()  # Player's movement vector
	
	# Controls (Keyboard and Gamepad)
	if Input.is_action_pressed("ui_right") or Input.get_joy_axis(0, JOY_AXIS_0) > 0.25:
		velocity.x += 1
	if Input.is_action_pressed("ui_left") or Input.get_joy_axis(0, JOY_AXIS_0) < -0.25:
		velocity.x -= 1
	if Input.is_action_pressed("ui_up") or Input.get_joy_axis(0, JOY_AXIS_1) < -0.25:
		velocity.y -= 1
	if Input.is_action_pressed("ui_down") or Input.get_joy_axis(0, JOY_AXIS_1) > 0.25:
		velocity.y += 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		# play animation here if have one
		
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
