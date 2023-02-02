extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	# Reference for text justification with BBCode: https://godotforums.org/d/18397-richtextlabel-alignment
	$YourScore.set("bbcode_text", "[center]" + str(GlobalVars._score) + "[/center]")
	var scores = GlobalVars.load_scores()
	$Score1.set("bbcode_text", "[right]" + str(scores[9]) + "[/right]")
	$Score2.set("bbcode_text", "[right]" + str(scores[8]) + "[/right]")
	$Score3.set("bbcode_text", "[right]" + str(scores[7]) + "[/right]")
	$Score4.set("bbcode_text", "[right]" + str(scores[6]) + "[/right]")
	$Score5.set("bbcode_text", "[right]" + str(scores[5]) + "[/right]")

# Called when unhandled input is detected
func _unhandled_input(event):
	if event.is_action_pressed("ui_escape"):
		# Quit game
		get_tree().quit()
	if event.is_action_pressed("ui_accept"):
		# Quit game
		get_tree().quit()
		# Reset and play again (WIP)
		GlobalVars.m_lives = 3
		GlobalVars.m_health = 1000
		GlobalVars._score = 0
		get_tree().change_scene("res://Scenes/Main.tscn")
	# Mark input as handled so it won't trigger multiple times per keypress
	get_tree().set_input_as_handled()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
