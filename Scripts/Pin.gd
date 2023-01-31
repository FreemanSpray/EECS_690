extends KinematicBody2D


#Variables
var velocity = Vector2(1,0)
var speed = 100
var hp = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var collision = move_and_collide(speed*velocity*delta)
	if collision:
		if collision.collider.name == "EnemyBarrier":
			# Inflict damage on player's life total
			GlobalVars._wasHit(1000)
			# Despawn
			queue_free()
		else:
			hp-=1
			if hp == 0:
				# Despawn if out of HP
				queue_free()
