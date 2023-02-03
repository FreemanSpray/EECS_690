extends Control

# Declare member variables here. Examples:
var rng

#Enemies
var enemy_nacho = preload("res://Scenes/Nacho.tscn")
var enemy_pin = preload("res://Scenes/Pin.tscn")
var enemy_shellby = preload("res://Scenes/Shellby.tscn")
var enemy_shoe = preload("res://Scenes/Shoe.tscn")

var enemyToSpawn = null
var locationToSpawn = null
var enemy = null

var laneOnePosition = Vector2(520,460)
var laneTwoPosition = Vector2(415,590)
var laneThreePosition = Vector2(300,740)
var laneFourPosition = Vector2(175,900)

onready var music_track = $Music


func _ready():
	rng = RandomNumberGenerator.new()
	rng.randomize()
	GlobalVars.m_parent = self
	music_track.play()
	

func _on_Timer_timeout():
	GlobalVars.m_difficulty += 1
	enemyToSpawn = rng.randi_range(1, 100)
	locationToSpawn = rng.randi_range(1, 4)
	
	
	#Currently equal chances for all enemies, can change as we decide difficulty
	if enemyToSpawn > 0 and enemyToSpawn <= 30:
		enemy = enemy_nacho
	elif enemyToSpawn > 30 and enemyToSpawn <= 70:
		enemy = enemy_pin
	elif enemyToSpawn > 70 and enemyToSpawn <= 90:
		enemy = enemy_shellby
	else:
		enemy = enemy_shoe
	# enemyToSpawn > 75 and enemyToSpawn <=100: Redundant
	
	#Spawning Enemy on Lane 1
	if locationToSpawn == 1:
		GlobalVars.newNode(enemy, laneOnePosition, GlobalVars.m_parent, .85)
	elif locationToSpawn == 2:
		GlobalVars.newNode(enemy, laneTwoPosition, GlobalVars.m_parent, .90)
	elif locationToSpawn == 3:
		GlobalVars.newNode(enemy, laneThreePosition, GlobalVars.m_parent, .95)
	else:
		GlobalVars.newNode(enemy, laneFourPosition, GlobalVars.m_parent, 1)	

func _exit_tree():
	GlobalVars.m_parent = null
