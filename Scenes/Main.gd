extends Control

export (PackedScene) var lane_scene
export (PackedScene) var monster_scene

# Declare member variables here. Examples:
var lanes
var rng
var ticks
var next_monster_id

# Called when the node enters the scene tree for the first time.
func _ready():
	lanes = [0, 0, 0, 0, 0]
	for i in range(0,5):
		lanes[i] = lane_scene.instance()
		lanes[i].m_lane_id = i
		lanes[i].m_monster_queue = []
	# Initialize RNG
	rng = RandomNumberGenerator.new()
	rng.randomize()
	# Initialize counters
	ticks = 0
	next_monster_id = 0

func get_random_lane():
	 return rng.randi_range(0, 4)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	ticks+=1
	if ticks > 300:
		ticks = 0
		var monster = monster_scene.instance()
		var spawn_lane = get_random_lane()
		var start_pos = lanes[spawn_lane].get_pos("mob")
		var dest_pos = lanes[spawn_lane].get_pos("player")
		monster.m_lane = spawn_lane
		monster.m_monster_id = next_monster_id
		monster.m_start_pos = start_pos
		monster.m_dest_pos = dest_pos
		next_monster_id+=1
		monster.set("position", start_pos)
		add_child(monster)
