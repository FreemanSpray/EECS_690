extends KinematicBody2D

var blueBall = preload("res://Scenes/BlueBall.tscn")
var greenBall = preload("res://Scenes/GreenBall.tscn")
var orangeBall = preload("res://Scenes/OrangeBall.tscn")
var purpleBall = preload("res://Scenes/PurpleBall.tscn")

# Declare member variables here:
var m_lane : int
var m_lives : int
var m_ballRndm
var m_ballToThrow
var m_throw_cooldown = 0
var rng
onready var sprite : Sprite = get_node("Sprite")

# Called when the node enters the scene tree for the first time.
func _ready():
	m_lane = 0
	m_lives = 3
	rng = RandomNumberGenerator.new()
	rng.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _unhandled_input(event):
	if event.is_action_pressed("ui_up"):
		changeLane("up")
	elif event.is_action_pressed("ui_down"):
		changeLane("down")
	elif event.is_action_pressed("ui_accept"):
		if m_throw_cooldown == 0:
			bowl()
	# Mark input as handled so it won't trigger multiple times per keypress
	get_tree().set_input_as_handled()
	
	
	
func bowl():
	#Randomizer to decide which ball to throw next
	m_ballRndm = rng.randi_range(1, 100)
	if m_ballRndm >=1 and m_ballRndm < 25:
		m_ballToThrow = blueBall
	elif m_ballRndm >=25 and m_ballRndm < 50:
		m_ballToThrow = greenBall
	elif m_ballRndm >=50 and m_ballRndm < 75:
		m_ballToThrow = orangeBall
	else:
		m_ballToThrow = purpleBall
	m_throw_cooldown = 30
		
		
	if m_lane == 0:
		GlobalVars.newNode(m_ballToThrow, Vector2(self.position.x, self.position.y + 60), GlobalVars.m_parent, .85)
	elif m_lane == 1:
		GlobalVars.newNode(m_ballToThrow, Vector2(self.position.x, self.position.y + 60), GlobalVars.m_parent, .90)
	elif m_lane == 2:
		GlobalVars.newNode(m_ballToThrow, Vector2(self.position.x, self.position.y + 60), GlobalVars.m_parent, .95)
	else:
		GlobalVars.newNode(m_ballToThrow, Vector2(self.position.x, self.position.y + 60), GlobalVars.m_parent, 1)
		



func changeLane(direction):
	if direction == "up":
		if m_lane > 0:
			m_lane-=1
			set("position", Vector2(m_lane * 80 + 1350, 150 * m_lane + 400))
			sprite.scale *= .90
	elif direction == "down":
		if m_lane < 3:
			m_lane+=1
			set("position", Vector2(m_lane * 80 + 1350, 150 * m_lane + 400))
			sprite.scale /= .90

func _process(_delta):
	if m_throw_cooldown > 0:
		m_throw_cooldown-=1
		
