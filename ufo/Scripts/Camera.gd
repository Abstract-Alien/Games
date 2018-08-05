extends Camera2D

var magnitude = 0
var time_left = 0
var is_shaking = false


func shake(new_magnitude, lifetime):
	if magnitude > new_magnitude:
		return
	
	magnitude = new_magnitude
	time_left = lifetime
	
	if is_shaking:
		return
		
	is_shaking = true
	
	while time_left > 0:
		var shake = Vector2()
		
		# Sometimes the shake isn't noticeable
		shake.x = rand_range(-magnitude, magnitude)
		shake.y = rand_range(-magnitude, magnitude)
		
		position = shake
		
		time_left -= get_process_delta_time()
		yield(get_tree(), "idle_frame")
	
	magnitude = 0
	position = Vector2(0, 0)
	is_shaking = false


func _on_Player_damaged():
	shake(2.5, 0.2)

