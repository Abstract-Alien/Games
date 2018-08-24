extends Container

onready var door = get_tree().get_root().get_node("World/Door")
onready var screensize = get_viewport_rect().size

func _ready():
	#$CheckButton.set_size(screensize)
	#print(screensize)
	#print($Background_Panel/CheckButton.size)
	pass


func _on_CheckButton_pressed():

	if door:
		#door.unlock()
		get_tree().set_pause(false)
		hide()
	pass # replace with function body
