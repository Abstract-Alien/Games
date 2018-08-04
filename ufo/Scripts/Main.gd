extends Node

export (PackedScene) var Mob

var score
var movement
var started
var touching
var shooting


func _ready():
	randomize()
	started = false
	touching = false
	shooting = false

	$MoveStick.set_process_input(false)
	$ShootStick.set_process_input(false)


func _process(delta):
	if started:
		
		if touching:
			movement = $MoveStick.get_direction()
			$Player.set_direction(movement)
			
		if shooting:
			$Player.set_shoot_direction($ShootStick.get_direction())
#			yield(get_tree().create_timer(0.1), "timeout")
#			get_node("Player/Laser").connect("damaged", self, "_on_Laser_body_entered")


func _on_Laser_body_entered():
	score += 1

func game_over():
	started = false
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
#	$Music.stop()
#	$DeathSound.play()
	yield(get_tree().create_timer(2), "timeout")
	get_tree().change_scene("res://Scenes/Main.tscn")
	
	

func new_game():
	started = true
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready!")
	yield(get_tree().create_timer(2), "timeout")
	$MoveStick.show()
	$MoveStick.set_process_input(true)
	$ShootStick.show()
	$ShootStick.set_process_input(true)
#	$Music.play()


func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_StartTimer_timeout():
	$MobTimer.start()
	#$ScoreTimer.start()


func _on_MobTimer_timeout():
	# Choose a random location on Path2D
	$MobPath/MobSpawnLocation.set_offset(randi())
	# Create a Mob instance and add it to the scene
	var mob = Mob.instance()
	add_child(mob)
	# Set the Mob's direction perpendicular to the path direction
	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
	# Set the Mob's position to a random location
	mob.position = $MobPath/MobSpawnLocation.position
	# Add some randomness to the direction
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	# Choose the velocity
	mob.set_linear_velocity(Vector2(rand_range(mob.min_speed, mob.max_speed), 0).rotated(direction))


func _on_HUD_start_game():
	new_game()


func _on_AnalogStick_touching():
	touching = true


func _on_AnalogStick_released():
	touching = false


func _on_ShootStick_shooting():
	shooting = true


func _on_ShootStick_not_shooting():
	shooting = false


### TODO

### lasers to instantiate on the outside of ufo
### if moving fast, lasers look like they aren't attached to ufo when shot. fix that

### improve screen shake
### particles or something else to signify player taking damage
### specific player death animation (explosion maybe)
### UFO starts smoking when one hit left
### pickups that will heal the UFO
### enemy movement animations
### particles or something to signify hitting an enemy
### specific enemy death animation
### dead enemies randomly drop healing powerups
### particle effect or animation to signify healing
### collider on environment so player can't go into black areas
### clamp analog sticks so the top part can't go outside of it's background
### buttons on top left of screen, one for menu, one for weapon select
### pushing either button pauses the game
### tapping outside of the weapon select menu closes it
### have to close the game menu manually
