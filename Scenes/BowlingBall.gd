extends Node2D

# Declare member variables here. Examples:
var m_lane
var m_ball_id
var m_start_pos = Vector2(0,0)
var m_dest_pos = Vector2(0,0)
var m_speed


# Called when the node enters the scene tree for the first time.
func _ready():
	m_speed = 10


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(_delta):
	if m_dest_pos != Vector2(0,0):
		var pos =  get("position")
		set("position", pos.move_toward(m_dest_pos, m_speed))
		if pos == m_dest_pos:
			queue_free() 
