extends Node2D

export (PackedScene) var bowling_ball_scene

# Declare member variables here. Examples:
var m_lane
var m_lives
var m_next_ball_id


# Called when the node enters the scene tree for the first time.
func _ready():
	m_lane = 0
	m_lives = 3
	m_next_ball_id = 0


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
	var ctrl = get_parent()
	var ball = bowling_ball_scene.instance()
	var spawn_lane = m_lane
	print(spawn_lane)
	# subtract player position to get original frame coordinates 
	# (comment is irrelevant now that we attach children to main instead of player)
	var start_pos = ctrl.lanes[spawn_lane].get_pos("player")
	var dest_pos = ctrl.lanes[spawn_lane].get_pos("mob")
	ball.m_lane = spawn_lane
	ball.m_ball_id = m_next_ball_id
	ball.m_start_pos = start_pos
	ball.m_dest_pos = dest_pos
	m_next_ball_id+=1
	ball.set("position", start_pos)
	ctrl.add_child(ball)
	
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
