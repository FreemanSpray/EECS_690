extends KinematicBody2D

var explosion = preload("res://Scenes/Explosion.tscn")

#Variables
var velocity = Vector2(1,0)
var speed = 100
var hp = 1

onready var _animated_sprite = $PinEnemy

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_animated_sprite.play("default")
	var collision = move_and_collide(speed*velocity*delta)
	if collision:
		if collision.collider.name == "EnemyBarrier":
			# Inflict damage on player's life total
			#if self.scale.x > .5:
			GlobalVars._wasHit(1000)
			GlobalVars.newNode(explosion, self.position, GlobalVars.m_parent, 1)
			# Despawn
			queue_free()
		else:
			hp-=1
			# Despawn ball that hit
			collision.collider.queue_free()
			if hp == 0:
				# add points
				GlobalVars._score+=500
				# Despawn if out of HP
				queue_free()
