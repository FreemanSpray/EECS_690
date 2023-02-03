extends AnimatedSprite


var timeElapsed = 100


# Called when the node enters the scene tree for the first time.
func _ready():
	 # Replace with function body.
	pass
	
func _process(delta):
	if timeElapsed <= 0:
		queue_free()
	else:
		timeElapsed -= 1
