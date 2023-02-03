extends Node2D

var full_health = preload("res://Scenes/3HP.tscn")
var two_health = preload("res://Scenes/2HP.tscn")
var one_health = preload("res://Scenes/1HP.tscn")
var threeLives = null
var twoLivesA = null
var twoLivesB = null
var oneLife = null

var m_timerCount = 0
var m_lives = 3
var m_health = 1000
var m_parent = null
var m_difficulty = 0
var _score = 0
var healthPosition = Vector2(600,340)

# Called when the node enters the scene tree for the first time.
func _ready():
	oneLife = newNode(one_health, healthPosition, m_parent, 1)
	oneLife.visible = false
	twoLivesA = newNode(two_health, healthPosition, m_parent, 1)
	twoLivesA.visible = false
	twoLivesB = newNode(two_health, Vector2(700,340), m_parent, 1)
	twoLivesB.visible = false
	threeLives = newNode(full_health, healthPosition, m_parent, 1)
	
func newNode(node, location, _parent, scaleMult):
	var newNode = node.instance()
	$Hangar.add_child(newNode)
	newNode.global_position = location
	newNode.scale *= scaleMult
	return newNode

func _wasHit(damageTaken):
	m_health -= damageTaken
	if m_health <= 0:
		m_health = 1000
		m_lives -= 1
	if m_lives == 0:
		save_score()
		get_tree().change_scene("res://Scenes/GameOver.tscn")

func save_score():
	print(GlobalVars._score)
	var file = File.new()
	# Open file for reading
	file.open("user://save_game.dat", File.READ_WRITE)
	# Read text
	var scores_read_text = file.get_as_text()
	print(scores_read_text)
	# Extract scores from text
	var scores_str = scores_read_text.split(" ")
	# Convert to int so sort works
	print(scores_str)
	var scores = []
	for i in range(0, 10):
		# Insert 0s if < 10 scores
		if i > scores_str.size() - 1:
			scores.append(0)
		else:
			scores.append(int(scores_str[i]))
	print(scores)
	# Append new score
	scores.append(GlobalVars._score)
	print(scores)
	# Sort
	scores.sort()
	print(scores)
	# Drop min value from among 11 scores
	scores.remove(0)
	print(scores)
	# Stringify new top ten scores
	var scores_write_text = ""
	for i in range(0, 10):
		scores_write_text = scores_write_text + str(scores[i])
		if i != 10:
			scores_write_text = scores_write_text + " "
	print(scores_write_text)
	# Write results
	file.store_string(scores_write_text)
	file.close()

func load_scores():
	var file = File.new()
	# Open file for reading
	file.open("user://save_game.dat", File.READ)
	# Read text
	var scores_read_text = file.get_as_text()
	# Extract scores from text
	var scores_str = scores_read_text.split(" ")
	# Convert to int so sort works
	print(scores_str)
	var scores = []
	for i in range(0, 10):
		# Insert 0s if < 10 scores
		if i > scores_str.size() - 1:
			scores.append(0)
		else:
			scores.append(int(scores_str[i]))
	file.close()
	return scores
	
# Only used for debugging / resetting scores before release. Not for use in-game.	
func reset_scores():
	var file = File.new()
	file.open("user://save_game.dat", File.WRITE)
	file.store_string("")
	file.close()


func _on_Timer_timeout():
	if m_lives == 2:
		threeLives.visible = false
		twoLivesA.visible = true
		twoLivesB.visible = true
	elif m_lives == 1:
		threeLives.visible = false
		twoLivesA.visible = false
		twoLivesB.visible = false
		oneLife.visible = true
		
	if m_timerCount == 0:
		twoLivesA.set_flip_h(true)
		oneLife.set_flip_h(true)
		twoLivesA.scale *= 1.15
		oneLife.scale *= 1.25
	elif m_timerCount == 1:
		twoLivesB.set_flip_h(true)
		oneLife.set_flip_h(false)
		twoLivesB.scale *= 1.15
	elif m_timerCount == 2:
		twoLivesA.set_flip_h(false)
		oneLife.set_flip_h(true)
		twoLivesA.scale /= 1.15
		oneLife.scale /= 1.25
	else:
		twoLivesB.set_flip_h(false)
		oneLife.set_flip_h(false)
		twoLivesB.scale /= 1.15
		m_timerCount = -1
	m_timerCount += 1
