extends Node2D


var m_lives = 3
var m_health = 1000
var m_parent = null
var m_difficulty = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func newNode(node, location, parent, scaleMult):
	var newNode = node.instance()
	parent.add_child(newNode)
	newNode.global_position = location
	newNode.scale *= scaleMult
	return newNode

func _wasHit(damageTaken):
	m_health -= damageTaken
	if m_health <= 0:
		m_health = 1000
		m_lives -= 1
		
	if m_lives == 0:
		get_tree().change_scene("res://Scenes/GameOver.tscn")
		queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
