extends RigidBody2D

export (int) var min_speed
export (int) var max_speed

onready var health_pickup = load("res://Scenes/HealthPickup.tscn")


func _on_Visibility_screen_exited():
	queue_free()


func _on_Mob_body_entered(body):
	if body.is_in_group("PlayerFire"):
		var main = get_parent()
		var player = main.get_node("Player")
		main.score += 1
		main.get_node("HUD").update_score(main.score)
		var pos = global_position
		if player.player_health < 3 && randi() % 20 < 4:
			var hp = health_pickup.instance()
			main.add_child(hp)
			hp.position = pos

