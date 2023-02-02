extends Node2D


var m_lives = 3
var m_health = 1000
var m_parent = null
var m_difficulty = 0
var _score = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

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
