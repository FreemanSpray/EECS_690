extends KinematicBody2D

var enemy_pin = preload("res://Scenes/Pin.tscn")
var explosion = preload("res://Scenes/Explosion.tscn")

#Variables
var velocity = Vector2(1,0)
var speed = 60
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
			GlobalVars.newNode(explosion, self.position, GlobalVars.m_parent, 1)
			queue_free()
		else:
			hp-=1
			# Despawn ball that hit
			collision.collider.queue_free()
			if hp == 0:
				# add points
				GlobalVars._score+=2000
				GlobalVars._wasHit(-10)
				# Despawn if out of HP
				queue_free()
				#Adding Smaller Enemies
				GlobalVars.newNode(enemy_pin, self.position, GlobalVars.m_parent, self.scale * .5)
				GlobalVars.newNode(enemy_pin, self.position, GlobalVars.m_parent, self.scale * .5)
				queue_free()
