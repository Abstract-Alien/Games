extends Area2D

onready var tween = get_node("Tween")
onready var is_unlocked = false

onready var puzzle = get_tree().get_root().get_node("World/HUD/Popup_Puzzle")
onready var stick = get_tree().get_root().get_node("World/HUD/Move_Stick")

func _on_Door_body_entered(body):
	
	if body.is_in_group("Player"):
		#print("pop up puzzle")
		if stick:
			stick.reset_direction()
		
		get_tree().set_pause(true)
		puzzle.set_visible(true)
#		if is_unlocked:
#			var open_pos = Vector2(position.x - 350, position.y)
#			tween.interpolate_property(self, "position", position, open_pos, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
#			tween.start()
		
	pass # replace with function body


func unlock():
	is_unlocked = true
	if is_unlocked:
		var open_pos = Vector2(position.x - 350, position.y)
		tween.interpolate_property(self, "position", position, open_pos, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.start()


func _on_Door_body_exited(body):
	if body.is_in_group("Player"):
		puzzle.set_visible(false)
	pass # replace with function body
