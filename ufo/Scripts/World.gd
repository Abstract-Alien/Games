extends Node2D

var touching

func _ready():
	touching = false
	pass

func _process(delta):
	if touching:
		$UFO.set_direction($HUD/Move_Stick.get_direction())


func _on_Move_Stick_touching():
	# needs to be active if using _process in UFO script (eliminates movement delay)
	#touching = true
	pass


func _on_Move_Stick_released():
	touching = false






#### TODO ####


# figure out why movement and tilting glitches sometimes (usually diagonally)
	# think it has something to do with multiplying by delta in _physics_process
	# try setting up a kinematic or static body on original ufo
# movement stops suddenly if let go really fast
# better UFO movement particles
# get lasers to shoot out of UFO
# build a minimap and make it accessible through UI button
# scanner button emits a signal and highlights objects that are interactable
# have a screen popup once entered area by door
# popup makes the game pause
# should be able to exit the popup
# be able to push a button in popup to open the door
# make the popup into a puzzle
# door opens when puzzle is solved
# environmental hazard that can damage the player
# small screen shake when taking damgage
# player needs to be able to take damage and visibly change when done so
# player needs to be able to heal through item pickups
