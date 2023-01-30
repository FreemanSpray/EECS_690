extends Node2D


# Declare member variables here. Examples:
var m_lane_id
var m_monster_queue


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func get_pos(loc):
	if loc == "mob":
		return Vector2(-50, 90 + 225*m_lane_id)
	if loc == "player":
		return Vector2(1500, 90 + 225*m_lane_id)
	return Vector2(0, 0)
		
