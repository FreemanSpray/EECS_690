extends Node2D

# Declare member variables here. Examples:
var m_lane
var m_monster_id
var m_start_pos = Vector2(0,0)
var m_dest_pos = Vector2(0,0)
var m_speed


# Called when the node enters the scene tree for the first time.
func _ready():
	m_speed = 5


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(_delta):
	if m_dest_pos != Vector2(0,0):
		set("position", get("position").move_toward(m_dest_pos, m_speed))
