extends Node2D


# Declare member variables here. Examples:
var m_lane
var m_lives


# Called when the node enters the scene tree for the first time.
func _ready():
	m_lane = 0
	m_lives = 3


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _unhandled_input(event):
	if event.is_action_pressed("ui_up"):
		changeLane("up")
	elif event.is_action_pressed("ui_down"):
		changeLane("down")
	elif event.is_action_pressed("ui_accept"):
		bowl()
	# Mark input as handled so it won't trigger multiple times per keypress
	get_tree().set_input_as_handled()

func bowl():
	print("Bowled!")
	
func changeLane(direction):
	if direction == "up":
		if m_lane != 0:
			m_lane-=1
			print("up ->" + str(m_lane))
			set("position", Vector2(1500, 15 + 50*1.5 + (100+50)*1.5*m_lane))
	elif direction == "down":
		if m_lane != 4:
			m_lane+=1
			print("down ->" + str(m_lane))
			set("position", Vector2(1500, 15 + 50*1.5 + (100+50)*1.5*m_lane))
