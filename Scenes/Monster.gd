extends KinematicBody2D

# Declare member variables here. Examples:
var m_lane
var m_monster_id
var m_start_pos = Vector2(0,0)
var m_dest_pos = Vector2(0,0)
var m_speed = 250
var m_velocity = Vector2(1,0)
var m_hp = 2


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	# We use collision in the kineticBody itself rather than with an Area2D because it is simpler 
	# (and because I couldn't get the Area 2D to work with kinematicBodies - see supposed explanation of the 
	# other method here:  https://stackoverflow.com/questions/66906099/how-do-i-detect-collision-in-godot).
	var pos = get("position")
	if pos == m_dest_pos:
		return
	if m_dest_pos != Vector2(0,0):
	# Manual movement like below does not allow for collisions, according to https://godotengine.org/qa/58425/collision-between-two-kinematic-bodies
	#	set("position", get("position").move_toward(m_dest_pos, m_speed))
		m_velocity = m_velocity.normalized() * m_speed
		var collision = move_and_collide(m_velocity*delta)
		if collision:
			m_hp-=1
			if m_hp == 0:
				queue_free()
