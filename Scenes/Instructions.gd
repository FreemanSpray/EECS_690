extends Control


var tick = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called when unhandled input is detected
func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		# Quit game
		get_tree().quit()
	elif event.is_action_pressed("ui_accept"):
		# Start game
		get_tree().change_scene("res://Scenes/Main.tscn")
	# Mark input as handled so it won't trigger multiple times per keypress
	get_tree().set_input_as_handled()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	tick+=1
	if tick == 500:
		get_tree().change_scene("res://Scenes/Main.tscn")
