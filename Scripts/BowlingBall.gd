extends KinematicBody2D

# Declare member variables here. Examples:
var m_lane
var m_ball_id
var m_start_pos = Vector2(0,0)
var m_dest_pos = Vector2(0,0)
var m_speed = 500
var m_velocity = Vector2(-1,0)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	var pos = get("position")
	if pos == m_dest_pos:
		queue_free() 
	if m_dest_pos != Vector2(0,0):
		m_velocity = m_velocity.normalized() * m_speed
		var collision = move_and_collide(m_velocity*delta)
		if collision:
			queue_free()
