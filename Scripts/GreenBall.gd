extends KinematicBody2D


#Variables
var velocity = Vector2(-1,0)
var speed = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var collision = move_and_collide(speed*velocity*delta)
	if collision:
		if collision.collider.name == "BallBarrier":
			# Despawn if it never hit a monster
			queue_free()
