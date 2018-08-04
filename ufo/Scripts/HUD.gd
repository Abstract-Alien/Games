extends CanvasLayer

signal start_game

var started = false

func _ready():
	set_process_input(true)

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()


func show_game_over():
	
	show_message("GAME OVER")
	yield($MessageTimer, "timeout")
	#$StartButton.show()
	$TapMessage.show()
	$MessageLabel.text = "UFO"
	$MessageLabel.show()
	started = false


func update_score(score):
	$ScoreLabel.text = str(score)
	


func _on_MessageTimer_timeout():
	$MessageLabel.hide()


func _input(event):
	if !started:
		if event is InputEventScreenTouch:
			started = true
			$TapMessage.hide()
			emit_signal("start_game")


func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")


