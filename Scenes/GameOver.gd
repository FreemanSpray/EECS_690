extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var ticks = 0
var current_selector = 0
var letter_indices = [0,0,0]
var alphabet = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z",]


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
	print(event)
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
	if event.is_action_pressed("ui_up"):
		adjust_letter("up")
	if event.is_action_pressed("ui_down"):
		adjust_letter("down")
	if event.is_action_pressed("ui_left"):
		if current_selector != 0:
			current_selector-=1
			$Cursor.set("rect_position", Vector2($Cursor.get("rect_position").x - 80, $Cursor.get("rect_position").y))
	if event.is_action_pressed("ui_right"):
		if current_selector != 2:
			current_selector+=1
			$Cursor.set("rect_position", Vector2($Cursor.get("rect_position").x + 80, $Cursor.get("rect_position").y))
	# Mark input as handled so it won't trigger multiple times per keypress
	get_tree().set_input_as_handled()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ticks+=1
	if ticks == 30:
		var cursor_status = $Cursor.get("visible")
		if cursor_status:
			$Cursor.hide()
		else:
			$Cursor.show()
		ticks = 0
		
func adjust_letter(direction):
	var selector = null
	if current_selector == 0:
		selector = $LetterSelector1
	elif current_selector == 1:
		selector = $LetterSelector2
	else:
		selector = $LetterSelector3		
	if direction == "up":
		if letter_indices[current_selector] != 25:
			letter_indices[current_selector]+=1
	elif direction == "down":
		if letter_indices[current_selector] != 0:
			letter_indices[current_selector]-=1
	selector.set("text", alphabet[letter_indices[current_selector]])
