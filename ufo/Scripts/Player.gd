extends Area2D

signal hit
signal damaged

export (PackedScene) var Laser
export (int) var speed  # How fast player will move

var screensize          # size of the game window
var direction = Vector2()
var shoot_direction
var tween
var shooting
var acceleration

var player_health

var temp


func _ready():
	player_health = 3
	speed = 0
	screensize = get_viewport_rect().size
	tween = get_node("Tween")
	shooting = false
	acceleration = 0


func _process(delta):
	$Trail.emitting = false
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

	#if acceleration > 50:
	velocity +=  direction
	lean(direction.x)
	
	if shooting:
		if $ShootTimer.time_left == 0:
			shoot()
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$Trail.emitting = true
		# play animation here if have one
	
	else:
		$Trail.emitting = false

	
	position += velocity * delta
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)


func set_shoot_direction(dir):
	temp = dir
	shoot_direction = Vector2(-dir.y, dir.x).angle()
	shooting = true


func shoot():
	var laser = Laser.instance()
	
	$ShootPos.add_child(laser)
	laser.position = position# + temp
	laser.rotation = shoot_direction
	laser.set_linear_velocity(Vector2(0, laser.speed).rotated(shoot_direction))
	$ShootTimer.start()



func _on_ShootStick_not_shooting():
	shooting = false


func _on_Player_body_entered(body):
	body.queue_free()
	player_health -= 1
	print("hit")
	emit_signal("damaged")
	### particle of taking damage
	### if health == 2 set the particle system to be more smokey
	### if health == 1 set the particle system to be really smokey
	### if health == 0 make a little explosion
	if player_health == 0:
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
	tween.interpolate_property(self, "speed", speed, 0, 0.6, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()
	

	#speed = 0
	#acceleration = 0
	### need to make it so speed doesn't just jump to 0 if finger let go and pressed again


func _on_AnalogStick_touching():
	# Find the hypotenuse of direction.x and direction.y
	acceleration = (direction.x * direction.x) + (direction.y * direction.y)
	acceleration = clamp(sqrt(acceleration), 0, 100)
	acceleration *= 4#2.3
	#acceleration += speed
	acceleration = clamp(acceleration, 0, 220)

	tween.interpolate_property(self, "speed", speed, acceleration, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()

func lean(direc):
	tween.interpolate_property(self, "rotation", 0, direc * speed / 100, 20, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
	self.rotation = clamp(self.rotation, -0.08, 0.08)
	
#	yield(get_tree().create_timer(5), "timeout")
#	tween.interpolate_property(self, "rotation", direction, 0, 20, Tween.TRANS_LINEAR, Tween.EASE_IN)
#	tween.start()






