extends CharacterBody3D



@export var is_destroyed = false
var SPEED = 1.0

var gravity = 8.0
# Called when the node enters the scene tree for the first time.
@onready var animations =  $AnimationTree
@onready var player = $"../../player"
@onready var walls = $"../../walls"
@onready var enemy_array = $".."
@onready var proximity = $proximity_attack
@onready var ability_cards = $"../../array_cards"

@onready var healt_array =  [$"healt_bar/25", $"healt_bar/50", $"healt_bar/75", $"healt_bar/100", $healt_bar/frame]
@export var healt = 100
@export var _break = false
@export var spawn_skill = true



var player_random_skills = [7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 4, 0, 2, 0, 2, 0, 0, 4, 4, 0, 0, 0, 0, 1, 0, 7, 0, 0, 0, 0, 0, 7, 0, 0, 7, 1, 7, 4, 6, 0, 0, 0, 5, 7, 1, 3, 7, 1, 0, 7, 7, 0, 7, 7, 1, 7, 1, 7, 0, 0, 5, 6, 0, 7, 4, 0, 7, 4, 0, 1, 2, 0, 0, 7, 7, 0, 7, 0, 0, 7, 4, 0, 0, 6, 0, 2, 4, 0, 7, 2, 0, 0, 7, 2, 0, 7, 0, 0, 0, 0, 1, 0, 2, 3, 0, 0, 7, 4, 2, 3, 1, 0, 5, 0, 0, 6, 0, 4, 0, 0, 0, 4, 3, 0, 0, 2, 1, 0, 0, 0, 0, 1, 0, 0, 7, 7, 0, 0, 7, 7, 0, 2, 0, 7, 5, 3, 5, 7, 7, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 7, 7, 0, 0, 7, 5, 0, 7, 0, 6, 7, 7, 1, 1, 0, 0, 0, 5, 0, 0, 1, 0, 0, 2, 0, 7, 0, 0, 0, 7, 0, 7, 6, 0, 1, 0, 1, 7, 1, 4, 0, 7, 7, 0, 7, 5, 7, 1, 0, 3, 0, 5, 4, 1, 2, 0, 2, 4, 0, 2, 7, 0, 0, 0, 2, 7, 0, 0, 0, 0, 7, 5, 0, 0, 0, 0, 3, 0, 3, 1, 7, 5, 2, 7, 7, 7, 0, 7, 0, 0, 0, 0, 0, 7, 4, 0, 2, 0, 0, 0, 7, 7, 0, 0, 0, 2, 0, 0, 0, 2, 0, 0, 7, 0, 1, 3, 7, 0, 0, 7, 7, 5, 0, 7, 3, 1, 2, 1, 0, 0, 0, 0, 0, 0, 3, 0, 0, 7, 0, 0, 0, 0, 0, 6, 0, 0, 0, 1, 0, 7, 0, 0, 0, 0, 0, 2, 0, 0, 7, 1, 0, 0, 0, 0, 0, 2, 0, 7, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 7, 7, 2, 4, 7, 7, 0, 7, 1, 0, 7, 0, 7, 0, 0, 0, 2, 0, 0, 0, 0, 2, 0, 0, 3, 7, 0, 0, 1, 7, 4, 0, 0, 1, 0, 0, 7, 1, 2, 0, 0, 1, 5, 0, 1, 0, 1, 0, 3, 7, 0, 0, 0, 0, 5, 0, 1, 0, 7, 5, 0, 1, 0, 0, 6, 0, 0, 0, 0, 0, 0, 5, 0, 1, 0, 2, 0, 7, 1, 0, 0, 7, 1, 0, 7, 7, 0, 7, 7, 4, 7, 2, 4, 0, 0, 7, 0, 0, 0, 7, 0, 1, 1, 0, 4, 0, 0, 4, 0, 0, 0, 0, 7, 5, 0, 6, 0, 0, 1, 5, 2, 0, 0, 7, 1, 5, 0, 0, 0, 7, 7, 1, 0, 0, 0, 1, 0, 7, 0, 1, 1, 0, 0, 7, 0, 7, 0, 0, 0, 2, 7, 0, 7, 0, 0, 0, 6, 1, 7, 0, 4, 7, 4, 0, 0, 0, 0, 7, 5, 0, 0, 0, 5, 1, 1, 7, 0, 0, 0, 6, 6, 2, 6, 4, 0, 5, 0, 0, 5, 7, 0, 0, 7, 1, 1, 3, 7, 2, 0, 0, 7, 7, 7, 7, 4, 3, 4, 5, 1, 0, 3, 0, 3, 7, 5, 0, 0, 0, 7, 7, 0, 3, 0, 0, 0, 1, 3, 0, 0, 6, 7, 1, 0, 0, 0, 0, 7, 7, 0, 0, 6, 3, 1, 0, 0, 4, 0, 1, 4, 0, 7, 0, 1, 1, 0, 0, 0, 7, 7, 0, 0, 0, 4, 5, 0, 0, 0, 7, 0, 3, 0, 7, 2, 4, 7, 5, 1, 4, 1, 5, 0, 0, 0, 0, 5, 0, 7, 7, 5, 7, 0, 0, 7, 0, 2, 2, 6, 7, 0, 0, 0, 7, 7, 6, 0, 4, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 7, 7, 1, 0, 7, 5, 0, 0, 0, 1, 0, 1, 0, 0, 7, 0, 3, 0, 3, 0, 0, 7, 7, 0, 0, 0, 7, 1, 6, 7, 1, 0, 1, 7, 1, 1, 5, 7, 7, 6, 1, 2, 0, 0, 0, 0, 0, 0, 7, 0, 7, 5, 0, 5, 0, 0, 7, 7, 5, 0, 0, 0, 2, 5, 0, 0, 1, 0, 7, 4, 1, 0, 6, 7, 7, 5, 1, 1, 0, 4, 6, 0, 0, 0, 7, 0, 5, 0, 0, 4, 0, 0, 0, 5, 0, 2, 4, 0, 4, 0, 7, 3, 7, 7, 0, 0, 2, 0, 7, 7, 0, 0, 1, 0, 5, 7, 0, 0, 2, 0, 4, 7, 0, 1, 7, 0, 0, 0, 7, 1, 5, 0, 4, 0, 0, 0, 7, 0, 0, 0, 2, 7, 0, 0, 0, 1, 2, 5, 0, 7, 0, 0, 4, 7, 0, 6, 1, 7, 7, 0, 0, 0, 0, 3, 7, 0, 0, 0, 0, 0, 7, 0, 7, 7, 7, 7, 0, 3, 0, 7, 7, 7, 7, 2, 0, 7, 4, 0, 0, 7, 7, 0, 7, 1, 7, 7, 0, 4, 7, 1, 0, 5, 0, 7, 7, 7, 0, 5, 6, 7, 1, 2, 7, 0, 4, 0, 6, 1, 0, 0, 0, 4, 0, 0, 5, 6, 0, 2, 5, 0, 1, 7, 1, 5, 0, 0, 7, 0, 7, 1, 7, 0, 6, 2, 0, 0, 4, 3, 0, 7, 0, 0, 6, 7, 0, 0, 7, 0, 7, 4, 0, 6, 1, 0, 7, 0, 0, 7, 0, 1, 2, 0, 7, 6, 0, 0, 0, 0, 0, 1, 0, 2, 5, 6, 1, 1, 4, 5, 0, 7, 3, 7, 4, 7, 0, 0, 0, 0, 0, 7, 1, 0, 0, 0, 3, 0, 1, 0, 7, 4, 0, 0, 0, 1, 2, 0, 0, 1, 7, 5, 0, 0, 3, 1, 2, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 7, 1, 0, 4, 0, 0]
var skills = [preload("res://assets/models/ability_cards/caps10.tscn"), preload("res://assets/models/ability_cards/caps100.tscn"), preload("res://assets/models/ability_cards/caps1000.tscn"), preload("res://assets/models/ability_cards/Invincibility.tscn"),preload("res://assets/models/ability_cards/FatalityA.tscn"), preload("res://assets/models/ability_cards/FatalityB.tscn"), preload("res://assets/models/ability_cards/ExtendTime.tscn"), preload("res://assets/models/ability_cards/MedKit.tscn")]
var letters = ['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', 'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'z', 'x', 'c', 'v', 'b', 'n', 'm']

var damage_id_array = [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 2, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 2, 0, 0, 2, 3, 0, 0, 0, 2, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 3, 0, 1, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 2, 0, 0, 0, 3, 0, 1, 0, 2, 2, 0, 0, 0, 0, 1, 3, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 2, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 2, 0, 0, 1, 1, 0, 0, 0, 1, 0, 2, 0, 2, 1, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 2, 0, 1, 0, 0, 0, 1, 2, 0, 0, 2, 0, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 2, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 2, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 2, 0, 0, 3, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 2, 0, 0, 1, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 3, 0, 1, 2, 0, 0, 1, 0, 0, 0, 0, 0, 3, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 2, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 3, 1, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 1, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 2, 0, 1, 3, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 2, 1, 0, 0, 1, 1, 0, 0, 0, 0, 3, 0, 0, 0, 0, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 1, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 3, 0, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 2, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 2, 0, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 2, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 1, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 1, 2, 1, 2, 0, 0, 1, 0, 0, 2, 0, 2, 0, 1, 2, 0, 0, 0, 0, 3, 0, 0, 2, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 2, 0, 0, 0, 1, 0, 0, 2, 0, 0, 2, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1]
var damage_array =[2.38, 3.38, 6.68, 8.78]
var damage_count = 0.0


var queue_free_this = false
var _queue_free = false
var attack_state = false
var attack_state_timeout = false
var first_attack_state = false
var disabled_obj = false


func _ready():
	
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func get_distance_to_player():
	var player_position = Vector3(player.global_position.x, 0, player.global_position.z)
	var _position = Vector3(global_position.x, 0, global_position.z)
	var d = _position.distance_to(player_position)
	return(d)

func update_healt():

	if healt <= 0:
		rotation.z = deg_to_rad(90)
		healt_array[4].visible = false
		is_destroyed = true
		
	if healt >= 100:
		if healt_array[3].visible == false:
			healt_disable()
			healt_array[3].visible = true
	
	if healt < 100:
		if healt >= 75:
			if healt_array[2].visible == false:
				healt_disable()
				healt_array[2].visible = true
	if healt < 75:
		if healt >= 50:
			if healt_array[1].visible == false:
				healt_disable()
				healt_array[1].visible = true
	
	if healt < 50:
		if healt >= 25:
			if healt_array[0].visible == false:
				healt_disable()
				healt_array[0].visible = true
	
	if healt < 25:
		healt_disable()
		
func healt_disable():
	healt_array[0].visible = false
	healt_array[1].visible = false
	healt_array[2].visible = false
	healt_array[3].visible = false

func attack():
	if player.dead == true:
		if animations["parameters/Transition/current_state"] != 'simple_walking':
			if global_position.x < 0:
				global_position.x -= 0.13
			else:
				global_position.x += 0.13
				SPEED = 1.0
			animations["parameters/Transition/transition_request"] = "simple_walking" 
	if SPEED == 0:
		SPEED = 1.0
	if get_distance_to_player() <= 1.48 and player._invincibility == false and player.dead == false:
		attack_state = true

		if $attack_timeout_1.is_stopped() and attack_state_timeout == true:
			SPEED = 1

			attack_state_timeout = false	
		
		if attack_state_timeout == false:
			if get_distance_to_player() < 0.13:
				if animations["parameters/Transition/current_state"] != 'attack':
					animations["parameters/Transition/transition_request"] = "attack"
				var d_attack = Vector3(proximity.global_position.x, 0, proximity.global_position.z).distance_to(Vector3(player.global_position.x, 0, player.global_position.z))
				
				if d_attack  < 0.36:
					SPEED = 0.36
				if d_attack  < 0.1:
					
					if player.healt > 0:
						var damage = damage_array[damage_id_array[randi_range(0, damage_id_array.size()-1)]]
						
						if damage_count > 16.8:
							damage = 0.25

						player.healt = split_decimals(player.healt-damage, 2)
						damage_count += damage
 						
						
						
							
				
						$sfx/attack_sound.play()
						$attack_timeout_1.set("wait_time", randf_range(2.68, 3.38))
						$attack_timeout_1.start()
						attack_state_timeout = true
					if player.healt < 0:
						player.healt = 0
						
			else:
				if animations["parameters/Transition/current_state"] != 'simple_walking':
					animations["parameters/Transition/transition_request"] = "simple_walking"
			var walk = true
			if walk and $break.is_stopped():
				var direction = (transform.basis * Vector3(0, 0 ,-1)).normalized()
				if direction:
					velocity.x = direction.x * SPEED
					velocity.z = direction.z * SPEED

				else:
					velocity.x = move_toward(velocity.x, 0, SPEED)
					velocity.z = move_toward(velocity.z, 0, SPEED)	

	
	else:
		if $attack_timeout_1.is_stopped() == false:
			$attack_timeout_1.stop()
		
		attack_state = false	
		first_attack_state = false
		
func play_detection_sound():
	if get_distance_to_player() <= 1.48 and player._invincibility == false and player.dead == false:
		look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
		if $sfx/player_detect.get("playing") == false:
			$sfx/player_detect.play()

func destroyed():

	
	
	if $timer_destroy.is_stopped() and _queue_free == true:
		

		disable_wall()
		get_tree().root.get_children()[0].score +=1
		player.update_top_bar = true
		var id = player_random_skills[randi_range(0, player_random_skills.size()-1)]

		var obj = skills[id].instantiate()
		var temp = str(obj.name, '_', letters[randi_range(0, letters.size()-1)], letters[randi_range(0, letters.size()-1)], letters[randi_range(0, letters.size()-1)], text_adder(randi_range(1, 99999999), 8))
		obj.name = temp
						
						
		ability_cards.add_child(obj)
		var count = ability_cards.get_children().size()-1

		ability_cards.get_children()[count].global_position = Vector3(global_position.x, -0.138, global_position.z)
				
		queue_free()

	if queue_free_this == true:
		
		if $timer_destroy.is_stopped():
			
			$timer_destroy.set("one_shot", true)
			_queue_free = true
			queue_free_this = false
			$timer_destroy.start()

	if is_destroyed == true:
		

		queue_free_this = true
		is_destroyed = false
		animations["parameters/Transition/transition_request"] = "is_destroyed"

		
		$"RootNode/roboto-tv".set("cast_shadow", false)
		$RootNode/wheel_1.set("cast_shadow", false)
		$RootNode/wheel_2.set("cast_shadow", false)
		$RootNode/wheel_3.set("cast_shadow", false)
		$RootNode/wheel_4.set("cast_shadow", false)	

func _process(delta):
	if get_tree().root.get_children()[0].paused == false:

		if player._invincibility == false and disabled_obj == false:
			$sfx/player_detect.global_position = global_position
			$sfx/attack_sound.global_position = global_position
			
			if _break:
				_break = false
				$break.start()
			if not is_on_floor():
				velocity.y -= gravity * delta
			attack()
			#update_healt()
			play_detection_sound()
			#destroyed()	
			move_and_slide()
		else:
			SPEED = 0.0
		update_healt()
		destroyed()	
	
func split_decimals(num, decimals):
	var array = str(num).split('.')
	var a = array[0]
	if array.size() > 1:
	
		var b = array[1]
		var _len = len(b)
		if decimals > _len:
			decimals = _len
		var i = 0
		var c = decimals
		var d = ''
		var _array = b.split()
		while i<c:
			d = d+_array[i]
			i += 1
		
		
		num = float(str(a,'.',d))
		return num
	else:
		return float(num)
func text_adder(text,require):
	text = str(text)
	if len(text) == require:
		
		return text
	
	var i=1
	var c = require-len(text)
	while i <= c :
		
		text = str('0',text)
		
		i += 1

	return text
func disable_wall():
	var array = name.split('_')
	var id = str('wall_', array[1])
	var w = walls.get_children()
	var i = 0
	var c = w.size()-1
	
	while i<=c:
		if id == w[i].name:
			w[i].queue_free()
			break
		i+=1

