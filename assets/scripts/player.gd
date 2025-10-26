extends CharacterBody3D


var SPEED = 5.0
var JUMP_VELOCITY = 1.68


@onready var animation_player = $AnimationTree
@onready var CAMERA_CONTROLLER = $"../Camera3D"
@onready var TopBar = get_tree().root.get_children()[0].get_children()[1].get_children()[0]
@onready var ability_cards = $"../array_cards"

var player_random_skills = [7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 4, 0, 2, 0, 2, 0, 0, 4, 4, 0, 0, 0, 0, 1, 0, 7, 0, 0, 0, 0, 0, 7, 0, 0, 7, 1, 7, 4, 6, 0, 0, 0, 5, 7, 1, 3, 7, 1, 0, 7, 7, 0, 7, 7, 1, 7, 1, 7, 0, 0, 5, 6, 0, 7, 4, 0, 7, 4, 0, 1, 2, 0, 0, 7, 7, 0, 7, 0, 0, 7, 4, 0, 0, 6, 0, 2, 4, 0, 7, 2, 0, 0, 7, 2, 0, 7, 0, 0, 0, 0, 1, 0, 2, 3, 0, 0, 7, 4, 2, 3, 1, 0, 5, 0, 0, 6, 0, 4, 0, 0, 0, 4, 3, 0, 0, 2, 1, 0, 0, 0, 0, 1, 0, 0, 7, 7, 0, 0, 7, 7, 0, 2, 0, 7, 5, 3, 5, 7, 7, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 7, 7, 0, 0, 7, 5, 0, 7, 0, 6, 7, 7, 1, 1, 0, 0, 0, 5, 0, 0, 1, 0, 0, 2, 0, 7, 0, 0, 0, 7, 0, 7, 6, 0, 1, 0, 1, 7, 1, 4, 0, 7, 7, 0, 7, 5, 7, 1, 0, 3, 0, 5, 4, 1, 2, 0, 2, 4, 0, 2, 7, 0, 0, 0, 2, 7, 0, 0, 0, 0, 7, 5, 0, 0, 0, 0, 3, 0, 3, 1, 7, 5, 2, 7, 7, 7, 0, 7, 0, 0, 0, 0, 0, 7, 4, 0, 2, 0, 0, 0, 7, 7, 0, 0, 0, 2, 0, 0, 0, 2, 0, 0, 7, 0, 1, 3, 7, 0, 0, 7, 7, 5, 0, 7, 3, 1, 2, 1, 0, 0, 0, 0, 0, 0, 3, 0, 0, 7, 0, 0, 0, 0, 0, 6, 0, 0, 0, 1, 0, 7, 0, 0, 0, 0, 0, 2, 0, 0, 7, 1, 0, 0, 0, 0, 0, 2, 0, 7, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 7, 7, 2, 4, 7, 7, 0, 7, 1, 0, 7, 0, 7, 0, 0, 0, 2, 0, 0, 0, 0, 2, 0, 0, 3, 7, 0, 0, 1, 7, 4, 0, 0, 1, 0, 0, 7, 1, 2, 0, 0, 1, 5, 0, 1, 0, 1, 0, 3, 7, 0, 0, 0, 0, 5, 0, 1, 0, 7, 5, 0, 1, 0, 0, 6, 0, 0, 0, 0, 0, 0, 5, 0, 1, 0, 2, 0, 7, 1, 0, 0, 7, 1, 0, 7, 7, 0, 7, 7, 4, 7, 2, 4, 0, 0, 7, 0, 0, 0, 7, 0, 1, 1, 0, 4, 0, 0, 4, 0, 0, 0, 0, 7, 5, 0, 6, 0, 0, 1, 5, 2, 0, 0, 7, 1, 5, 0, 0, 0, 7, 7, 1, 0, 0, 0, 1, 0, 7, 0, 1, 1, 0, 0, 7, 0, 7, 0, 0, 0, 2, 7, 0, 7, 0, 0, 0, 6, 1, 7, 0, 4, 7, 4, 0, 0, 0, 0, 7, 5, 0, 0, 0, 5, 1, 1, 7, 0, 0, 0, 6, 6, 2, 6, 4, 0, 5, 0, 0, 5, 7, 0, 0, 7, 1, 1, 3, 7, 2, 0, 0, 7, 7, 7, 7, 4, 3, 4, 5, 1, 0, 3, 0, 3, 7, 5, 0, 0, 0, 7, 7, 0, 3, 0, 0, 0, 1, 3, 0, 0, 6, 7, 1, 0, 0, 0, 0, 7, 7, 0, 0, 6, 3, 1, 0, 0, 4, 0, 1, 4, 0, 7, 0, 1, 1, 0, 0, 0, 7, 7, 0, 0, 0, 4, 5, 0, 0, 0, 7, 0, 3, 0, 7, 2, 4, 7, 5, 1, 4, 1, 5, 0, 0, 0, 0, 5, 0, 7, 7, 5, 7, 0, 0, 7, 0, 2, 2, 6, 7, 0, 0, 0, 7, 7, 6, 0, 4, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 7, 7, 1, 0, 7, 5, 0, 0, 0, 1, 0, 1, 0, 0, 7, 0, 3, 0, 3, 0, 0, 7, 7, 0, 0, 0, 7, 1, 6, 7, 1, 0, 1, 7, 1, 1, 5, 7, 7, 6, 1, 2, 0, 0, 0, 0, 0, 0, 7, 0, 7, 5, 0, 5, 0, 0, 7, 7, 5, 0, 0, 0, 2, 5, 0, 0, 1, 0, 7, 4, 1, 0, 6, 7, 7, 5, 1, 1, 0, 4, 6, 0, 0, 0, 7, 0, 5, 0, 0, 4, 0, 0, 0, 5, 0, 2, 4, 0, 4, 0, 7, 3, 7, 7, 0, 0, 2, 0, 7, 7, 0, 0, 1, 0, 5, 7, 0, 0, 2, 0, 4, 7, 0, 1, 7, 0, 0, 0, 7, 1, 5, 0, 4, 0, 0, 0, 7, 0, 0, 0, 2, 7, 0, 0, 0, 1, 2, 5, 0, 7, 0, 0, 4, 7, 0, 6, 1, 7, 7, 0, 0, 0, 0, 3, 7, 0, 0, 0, 0, 0, 7, 0, 7, 7, 7, 7, 0, 3, 0, 7, 7, 7, 7, 2, 0, 7, 4, 0, 0, 7, 7, 0, 7, 1, 7, 7, 0, 4, 7, 1, 0, 5, 0, 7, 7, 7, 0, 5, 6, 7, 1, 2, 7, 0, 4, 0, 6, 1, 0, 0, 0, 4, 0, 0, 5, 6, 0, 2, 5, 0, 1, 7, 1, 5, 0, 0, 7, 0, 7, 1, 7, 0, 6, 2, 0, 0, 4, 3, 0, 7, 0, 0, 6, 7, 0, 0, 7, 0, 7, 4, 0, 6, 1, 0, 7, 0, 0, 7, 0, 1, 2, 0, 7, 6, 0, 0, 0, 0, 0, 1, 0, 2, 5, 6, 1, 1, 4, 5, 0, 7, 3, 7, 4, 7, 0, 0, 0, 0, 0, 7, 1, 0, 0, 0, 3, 0, 1, 0, 7, 4, 0, 0, 0, 1, 2, 0, 0, 1, 7, 5, 0, 0, 3, 1, 2, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 7, 1, 0, 4, 0, 0]
var skills = [preload("res://assets/models/ability_cards/caps10.tscn"), preload("res://assets/models/ability_cards/caps100.tscn"), preload("res://assets/models/ability_cards/caps1000.tscn"), preload("res://assets/models/ability_cards/Invincibility.tscn"),preload("res://assets/models/ability_cards/FatalityA.tscn"), preload("res://assets/models/ability_cards/FatalityB.tscn"), preload("res://assets/models/ability_cards/ExtendTime.tscn"), preload("res://assets/models/ability_cards/MedKit.tscn")]
var letters = ['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', 'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'z', 'x', 'c', 'v', 'b', 'n', 'm']

@onready var sfx = [$sfx/foot_steps, $sfx/foot_steps_running, $sfx/shoot]
@onready var raycasts = [null, null, $shoot]
@onready var enemy_array = $"../enemy_array"
@onready var collision = $CollisionShape3D2
@onready var catch = $RootNode/Skeleton3D/BoneAttachment3D3/Marker3D
@onready var walls = $"../walls"
@onready var _door_key = $"../key"

@onready var _key = false
@onready var _exit = false
@onready var _door_interact = $door_interact
@onready var _door_interact_a = $"../doors/door_1_interact_a"
@onready var _door_interact_b = $"../doors/door_1_interact_b"
@export var caps_added_sound = false

@export var extra_time_added_sound = false
@export var fatalitiy_added_sound = false
@export var invincibility_added_sound = false
@export var med_kit_added_sound = false
@export var Caps_10 = false
@export var Caps_100 = false
@export var Caps_1000 = false
@export var update_top_bar = false
@export var dead = false
@export var _invincibility = false
var invincibility_time = 0

var door_interact_count = 0
var door_2_interact_count = 0
var door_1_interact = false
var door_2_interact = false

@export var healt = 0

@export var med_kit = 0

@export var extend_time = 0

@export var invincibility = 0

@export var fatality_a = 0

@export var fatality_b = 0

var active_fatality = false
var active_fatality_b = false
@export var fataliti_b_activated = false
var temp_enemy_location = Vector3(0, 0, 0)
var enabled = true

var match_time = 600
var key_locations = [Vector3(-8.059, 0, 0.884), Vector3(1.177, 0, 0.884), Vector3(-6.157, 0, -6.005), Vector3(1.177, 0, -3.555), Vector3(-13.208, 0, 1.007), Vector3(-1.004, 0, -1.297), Vector3(8.501, 0, 6.007), Vector3(-8.344, 0, 6.007)]


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 10.0


var jump_state = false
var shoot_state = false
var _shoot_state = false
var player_status = 'idle'

var player_anim = 'idle'

var camera_state_position = Vector3()
var camera_state_rotation = Vector3()

var enemy_detected = []

var game_over = false

var __delta = 0.0
var camera_yaw = 0.0
var camera_pitch = 0.0
var up = false
var down = false

@export var mouse_sensitivity = 0.00378
func _ready():
	
	
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	var dificulty = get_tree().root.get_children()[0].dificulty
	if get_tree().root.get_children()[0].level_selected == 'level_1':
	
		if dificulty == 'easy':
			match_time =240
			_door_key.global_position = key_locations[0]
		else:
		
			_door_key.global_position = key_locations[1]
			match_time = 180
	
	
	if get_tree().root.get_children()[0].level_selected == 'level_2':
	
		if dificulty == 'easy':
			match_time = 380
			
			_door_key.global_position = key_locations[2]
		else:
			_door_key.global_position = key_locations[3]
			match_time = 300
	
	if get_tree().root.get_children()[0].level_selected == 'level_3':
	
		if dificulty == 'easy':
			match_time = 480
			_door_key.global_position = key_locations[4]
		else:
			_door_key.global_position = key_locations[5]
			
			
			match_time = 420	
	
	if get_tree().root.get_children()[0].level_selected == 'level_4':
	
		if dificulty == 'easy':
			match_time = 680
			_door_key.global_position = key_locations[6]
		else:
			_door_key.global_position = key_locations[7]
			match_time = 600	
	
	
	
	TopBar.visible = true
	update_topbar()
	healt = get_tree().root.get_children()[0].healt

	update_topbar(true, seconds_to_time(match_time))
	match_time -= 1
	collision.set("disabled", true)
	CAMERA_CONTROLLER.global_position = $RootNode/character/Marker3D.global_position
	
	
	
	camera_state_position = CAMERA_CONTROLLER.global_position
	camera_state_rotation = CAMERA_CONTROLLER.rotation
	healt = 100
	
	healt_update()
	update_topbar()




func _physics_process(delta):
	if get_tree().root.get_children()[0].UpdateTopBar == true:
		get_tree().root.get_children()[0].UpdateTopBar = false
		update_topbar()
	if get_tree().root.get_children()[0].paused == false:
		if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		
		
		__delta = delta
		
		if healt == 0 and enabled == true:
		
			animation_player["parameters/player_state/transition_request"] = "dead"

			enabled = false
			healt_update()
			update_topbar()
			SPEED = 0.0
			
			dead = true
			match_time = 0

		if match_time <= 0 and game_over == false:
			
			update_topbar(true, '00:00')
			var key_update = get_tree().root.get_children()[0].get_children()[1].get_children()[0].get_children()[6].get_children()[0]
			key_update.text = '0'
			game_over = true
			$sfx/running_out_of_time.stop()
			$sfx/foot_steps.set("volume_db", -80)
			$sfx/foot_steps_running.set("volume_db", -80)
			_exit = true
			reset_ini()
			$sfx/game_over.play()
			$timers/GameOverExit.start()

			get_tree().root.get_children()[0].reload = true
			
		if _exit == false and enabled == true:
			
			if update_top_bar == true:
				update_top_bar = false
				update_topbar()
			
			play_card_sounds()
			door_interact()
			add_door_key()
			CAMERA_CONTROLLER.global_position = $RootNode/character/Marker3D.global_position
			CAMERA_CONTROLLER.global_position.y = 0.235
			CAMERA_CONTROLLER.rotation.y = rotation.y

			$sfx/foot_steps.global_position = global_position
			$sfx/foot_steps_running.global_position = global_position
			$sfx/shoot.global_position = global_position
			$sfx/door_close_from_other_side_001_.global_position = global_position
			$sfx/door_close_from_other_side_002_.global_position = global_position
			$sfx/door_close_from_other_side_003_.global_position = global_position
			$sfx/key_for_door_001_.global_position = global_position
			$sfx/key_for_door_002_.global_position = global_position
			$sfx/key_for_door_003_.global_position = global_position
			$sfx/key_for_exit_door_.global_position = global_position
			$sfx/unlock_level_.global_position = global_position
			$sfx/game_over.global_position = global_position
			$sfx/running_out_of_time.global_position = global_position
			$"sfx/25_left".global_position = global_position
			$"sfx/20_left".global_position = global_position
			$"sfx/15_left".global_position = global_position
			$"sfx/10_left".global_position = global_position
			$"sfx/5_left".global_position = global_position
			$"sfx/2_left".global_position = global_position
			$sfx/game_resume.global_position = global_position
			$sfx/game_finished.global_position = global_position
			$"sfx/1_left".global_position = global_position
			$"sfx/10_caps".global_position = global_position
			$"sfx/100_caps".global_position = global_position
			$"sfx/1000_caps".global_position = global_position
			$sfx/fatality.global_position = global_position
			
			# Add the gravity.
			if not is_on_floor():
				velocity.y -= gravity * delta
			
			detect_enemy()
			
			var distance_to_enemy = 800

			
			
			
			if typeof(enemy_detected) == 24:
				distance_to_enemy = Vector3(global_position.x, 0, global_position.z).distance_to(Vector3(enemy_detected.global_position.x, 0, enemy_detected.global_position.z))
				if distance_to_enemy < 0.04:
					if collision.get("disabled") == false:
						collision.set("disabled", true)
				else:
					if collision.get("disabled") == true:
						collision.set("disabled", false)
			else:
				distance_to_enemy = 800
			healt_update()
			player_sfx()
			added_ability()
			if shoot_state == false:
				camera_zoom()
				camera_rotation(delta)
				idle()
				walking()
				jump()
			if distance_to_enemy < 0.25:
				#$Camera3D.set("current", false)
				#$"../Camera3D".set("current", true)
				#if CAMERA_CONTROLLER.get("fov") > 68:
					#CAMERA_CONTROLLER.set("fov", 68)
				_shoot_state = true
			else:
				#if CAMERA_CONTROLLER.get("fov") < 100:
					#if not Input.is_action_pressed("camera_zoom"):
						#CAMERA_CONTROLLER.set("fov", 100)
					
				_shoot_state = false
			
			shoot()
			move_and_slide()
			
		
		else:
			if dead == false:
			
				if animation_player["parameters/player_state/current_state"] != 'idle':
					animation_player["parameters/player_state/transition_request"] = "idle"
			SPEED = 0.0

		if match_time < 60 and game_over == false and _exit == false:
			if match_time < 60:
				if match_time > 58:
					if $"sfx/1_left".get("playing") == false:
						$"sfx/1_left".play()
			if $sfx/running_out_of_time.get("playing") == false:
				if $"sfx/1_left".get("playing") == false:
					$sfx/running_out_of_time.play()
		if game_over == false:
			play_time_sounds()	
	else:
		if Input.mouse_mode != Input.MOUSE_MODE_VISIBLE:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		if animation_player["parameters/player_state/current_state"] != 'idle':
			animation_player["parameters/player_state/transition_request"] = "idle"	

func _input(event: InputEvent): 
	if get_tree().root.get_children()[0].paused == false:
		if healt > 0 and enabled == true and _exit == false: 
			if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED: 
				const base = 0.5
				const exponent = 10.0
				var weight = pow(base, __delta * exponent)
				weight = 1.0 - weight # Invert
				
				mouse_sensitivity = 0.002
				camera_yaw += -event.relative.x * mouse_sensitivity 
				rotation.y = lerp_angle(rotation.y, camera_yaw*1.8, weight*1.18) 
				camera_pitch += -event.relative.y * mouse_sensitivity

				var max_rotation = camera_pitch
				if max_rotation < 0:
					max_rotation = max_rotation*-1
				if max_rotation < 0.28:
					CAMERA_CONTROLLER.rotation.x = lerp_angle(CAMERA_CONTROLLER.rotation.x, camera_pitch*1.8, weight*1.8)

func healt_update():
	
	if healt != get_tree().root.get_children()[0].healt:
		get_tree().root.get_children()[0].healt = healt
		update_topbar()

func play_card_sounds():
	$sfx/caps_added.global_position = global_position
	$sfx/extra_time_added.global_position = global_position
	$sfx/fatalitiy_added.global_position = global_position
	$sfx/invincibility_added.global_position = global_position
	$sfx/med_kit_added.global_position = global_position
	
	if Caps_10 == true:
		Caps_10 = false
		
		$"sfx/10_caps".play()
	
	if Caps_100 == true:
		Caps_100 = false
		
		$"sfx/100_caps".play()
	
	if Caps_1000 == true:
		Caps_1000 = false
		
		$"sfx/1000_caps".play()
	
	if caps_added_sound == true:
		caps_added_sound = false
		$sfx/caps_added.play()
	if extra_time_added_sound == true:
		extra_time_added_sound = false
		$sfx/extra_time_added.play()
	if fatalitiy_added_sound == true:
		fatalitiy_added_sound = false
		$sfx/fatalitiy_added.play()
	if invincibility_added_sound == true:
		invincibility_added_sound = false
		$sfx/invincibility_added.play()
	if med_kit_added_sound == true:
		med_kit_added_sound = false
		$sfx/med_kit_added.play()

func update_topbar(_time = false, time_value = '00:00'):
	var statistics = get_tree().root.get_children()[0].get_children()[1].get_children()[0].get_children()[5]
	if _time == false:
		
		var _caps = statistics.get_children()[0]
		var _healt = statistics.get_children()[1]
		var _score = statistics.get_children()[2] 
		
		
		var _med_kit = get_tree().root.get_children()[0].get_children()[1].get_children()[0].get_children()[0].get_children()[0]
		var _extra_time = get_tree().root.get_children()[0].get_children()[1].get_children()[0].get_children()[1].get_children()[0]
		var _imunity = get_tree().root.get_children()[0].get_children()[1].get_children()[0].get_children()[2].get_children()[0]
		var _fatality1 = get_tree().root.get_children()[0].get_children()[1].get_children()[0].get_children()[3].get_children()[0]
		var _fatality2 = get_tree().root.get_children()[0].get_children()[1].get_children()[0].get_children()[4].get_children()[0]
		
		_score.text = text_adder(get_tree().root.get_children()[0].score, 8)
		_caps.text = text_adder(get_tree().root.get_children()[0].caps, 8)
		_healt.text = str(get_tree().root.get_children()[0].healt)
		_med_kit.text = str(get_tree().root.get_children()[0].med_kit)
		_extra_time.text = str(get_tree().root.get_children()[0].extra_time)
		_imunity.text = str(get_tree().root.get_children()[0].imunity)
		_fatality1.text = str(get_tree().root.get_children()[0].fatality1)
		_fatality2.text = str(get_tree().root.get_children()[0].fatality2)
	else:
		var __time = statistics.get_children()[3]
		__time.text = time_value


func add_door_key():
	if _key == false:
		if _door_key != null:
			var d = Vector3(_door_key.global_position.x, 0, _door_key.global_position.z).distance_to(Vector3(global_position.x, 0, global_position.z))
			if d < 0.13:
				_key = true
				_door_key.queue_free()
				$sfx/key_for_exit_door_.play()
				var key_update = get_tree().root.get_children()[0].get_children()[1].get_children()[0].get_children()[6].get_children()[0]
				key_update.text = '1'

func door_interact():
	
	var d = Vector3(global_position.x, 0, global_position.z).distance_to(Vector3(_door_interact_a.global_position.x, 0, _door_interact_a.global_position.z))

	if d > 1.43:
		if d < 1.68 and door_interact_count < 3:
			
			door_1_interact = true
	if _door_interact.is_colliding():
		if _door_interact.get_collider() != null:
			if _door_interact.get_collider().name == 'OtherSide' and door_1_interact == true:
				door_1_interact = false
				if door_interact_count == 0:
					$sfx/door_close_from_other_side_001_.play()
				if door_interact_count == 1:
					$sfx/door_close_from_other_side_002_.play()	
				if door_interact_count == 2:
					$sfx/door_close_from_other_side_003_.play()		
				door_interact_count += 1

	d = Vector3(global_position.x, 0, global_position.z).distance_to(Vector3(_door_interact_b.global_position.x, 0, _door_interact_b.global_position.z))
	if d > 1.43:
		if d < 1.68 and door_2_interact_count < 3:
			door_2_interact = true
		
	if _door_interact.is_colliding() and _key == false and _exit == false:
		if _door_interact.get_collider() != null:
			if _door_interact.get_collider().name == 'ExitDoor' and door_2_interact == true:
				door_2_interact = false
				if door_2_interact_count == 0:
					$sfx/key_for_door_001_.play()
				if door_2_interact_count == 1:
					$sfx/key_for_door_002_.play()	
				if door_2_interact_count == 2:
					$sfx/key_for_door_003_.play()		
				door_2_interact_count += 1
	
	if _door_interact.is_colliding() and _key == true:
		if _door_interact.get_collider() != null:
			if _door_interact.get_collider().name == 'ExitDoor':
				
				_exit = true
				_key = false
				$sfx/running_out_of_time.stop()
				$"sfx/2_left".stop()
				$"sfx/5_left".stop()
				$"sfx/10_left".stop()
				$"sfx/15_left".stop()
				$"sfx/20_left".stop()
				$"sfx/25_left".stop()

				var next_level = false

				if get_tree().root.get_children()[0].level_selected != 'level_4':
					if get_tree().root.get_children()[0].level_selected == 'level_1':
						if get_tree().root.get_children()[0].dificulty == 'easy':
							if get_tree().root.get_children()[0].level_1_easy_end == 0:
								next_level = true
								get_tree().root.get_children()[0].level_1_easy_end = 1
								
						if get_tree().root.get_children()[0].dificulty == 'hard':
							if get_tree().root.get_children()[0].level_1_hardest_end == 0:
								next_level = true
								get_tree().root.get_children()[0].level_1_easy_end = 1
								get_tree().root.get_children()[0].level_1_hardest_end = 1
														
					
					if get_tree().root.get_children()[0].level_selected == 'level_2':
			
						if get_tree().root.get_children()[0].dificulty == 'hard':
							if get_tree().root.get_children()[0].level_2_hardest_end == 0:
								next_level = true

								get_tree().root.get_children()[0].level_2_hardest_end = 1
																	
					if get_tree().root.get_children()[0].level_selected == 'level_3':
			
						if get_tree().root.get_children()[0].dificulty == 'hard':
							if get_tree().root.get_children()[0].level_3_hardest_end == 0:
								next_level = true

								get_tree().root.get_children()[0].level_3_hardest_end = 1
											
				
				
				$sfx/foot_steps.stop()
				$sfx/foot_steps_running.stop()
				if next_level == true:
					write_ini()
					$sfx/unlock_level_.play()
					$timers/LevelCompleteExit.start()
				
				else:
					if get_tree().root.get_children()[0].level_selected == 'level_4':
						write_ini()
						$sfx/game_finished.play()
						$timers/LevelCompleteExit2.start()
					else:
						write_ini()
						$sfx/game_resume.play()
						$timers/LevelCompleteExit3.start()
				
				var key_update = get_tree().root.get_children()[0].get_children()[1].get_children()[0].get_children()[6].get_children()[0]
				key_update.text = '0'
		
	

func play_time_sounds():

	if match_time < 121:
		if match_time > 119:
			if $"sfx/2_left".get("playing") == false:
				$"sfx/2_left".play()
	
	if match_time < 301:
		if match_time > 299:
			if $"sfx/5_left".get("playing") == false:
				$"sfx/5_left".play()	
	
	if match_time < 601:
		if match_time > 599:
			if $"sfx/10_left".get("playing") == false:
				$"sfx/10_left".play()	
	
	if match_time < 901:
		if match_time > 899:
			if $"sfx/15_left".get("playing") == false:
				$"sfx/15_left".play()		
	
	if match_time < 1201:
		if match_time > 1199:
			
			if $"sfx/20_left".get("playing") == false:
				$"sfx/20_left".play()			
	if match_time < 1501:
		if match_time > 1499:
			
			if $"sfx/25_left".get("playing") == false:
				$"sfx/25_left".play()

func added_ability():
	$sfx/wrong.global_position = global_position
	$sfx/added.global_position = global_position
	if Input.is_action_just_pressed("med_kit"):
		if get_tree().root.get_children()[0].med_kit <= 0:
			$sfx/wrong.play()
		else:
			get_tree().root.get_children()[0].med_kit -= 1
			$sfx/added.play()
			healt += 10
			update_topbar()

	if Input.is_action_just_pressed("extra_time"):
		if get_tree().root.get_children()[0].extra_time <= 0:
			$sfx/wrong.play()
		else:
			$"sfx/1_left".stop()
			$sfx/running_out_of_time.stop()
			match_time += 60
			get_tree().root.get_children()[0].extra_time -= 1
			$sfx/added.play()
			
			update_topbar()
	if Input.is_action_just_pressed("imunity"):
		if get_tree().root.get_children()[0].imunity <= 0:
			$sfx/wrong.play()
		else:
			if $RootNode/Skeleton3D/BoneAttachment3D2/shield.visible == false:
				$RootNode/Skeleton3D/BoneAttachment3D2/shield.visible = true
			if _invincibility == false:
				_invincibility = true
			invincibility_time += 60
			get_tree().root.get_children()[0].imunity -= 1
			$sfx/added.play()
			
			update_topbar()		


func detect_enemy():
	var enemy_list = enemy_array.get_children()
	var d = 800
	var _d = 800
	var _enemy = []
	var i = 0
	var c = enemy_list.size()-1
	var enemy_position = Vector3()
	var enemy = []
	var player_position = Vector3(global_position.x, 0, global_position.z)
	while i <= c:

		enemy = enemy_list[i]
		enemy_position = Vector3(enemy.global_position.x, 0, enemy.global_position.z)
		_d = player_position.distance_to(enemy_position)
		if _d <= d:
			_enemy = enemy
			d = _d
		i+=1
	enemy_detected = _enemy

func shoot():
	if Input.is_action_just_pressed("shoot_special_a") and shoot_state == false and _shoot_state == true:
		if get_tree().root.get_children()[0].fatality1 > 0:
			var player_position = Vector3($proximity_area.global_position.x, 0, $proximity_area.global_position.z)
			var obj_enemy = Vector3(enemy_detected.global_position.x, 0, enemy_detected.global_position.z)
			var d = player_position.distance_to(obj_enemy)	
			$sfx/fatality.play()
			if d < 0.45:
				look_at(obj_enemy, Vector3(Vector3.UP.x, 0.1, Vector3.UP.z))
			
			player_anim = 'shoot'
			$timers/fatality.start()
			active_fatality = true
			enemy_detected._break = true
			enemy_detected.disabled_obj = true	
			enemy_detected.healt -= 100 
			if animation_player["parameters/player_state/current_state"] != 'karateka_1':
					animation_player["parameters/player_state/transition_request"] = "karateka_1"
			$timers/default_shoot.start()
			player_status = animation_player["parameters/player_state/current_state"]
			shoot_state = true	
		else:
			$sfx/wrong.play()
	if Input.is_action_just_pressed("shoot_special_b") and shoot_state == false and _shoot_state == true:
		enable_enemy_collision(enemy_detected)
		if get_tree().root.get_children()[0].fatality2 > 0:
			fataliti_b_activated = true
			var player_position = Vector3($proximity_area.global_position.x, 0, $proximity_area.global_position.z)
			var obj_enemy = Vector3(enemy_detected.global_position.x, 0, enemy_detected.global_position.z)
			var d = player_position.distance_to(obj_enemy)	
			$sfx/fatality.play()
			if d < 0.45:
				look_at(obj_enemy, Vector3(Vector3.UP.x, 0.1, Vector3.UP.z))
			temp_enemy_location = enemy_detected.global_position
			
			disable_enemy_collision(enemy_detected)
			active_fatality = true
			
			enemy_detected._break = true
			
			enemy_detected.disabled_obj = true	
			
			enemy_detected.set("script", "")
			
			enemy_detected.reparent(catch)
			
			$timers/destroy_enemy.start()
			active_fatality_b = true
			$timers/default_shoot.set("wait_time", 0.68)
			$timers/fatality.set("wait_time", 0.688)
			$timers/fatality_dec.set("wait_time", 1.68)
			player_anim = 'shoot'
			$timers/fatality.start()

			
			if animation_player["parameters/player_state/current_state"] != 'fatality':
					animation_player["parameters/player_state/transition_request"] = "fatality"
			$timers/default_shoot.start()
			player_status = animation_player["parameters/player_state/current_state"]
			shoot_state = true	
		else:
			$sfx/wrong.play()	
			
	if Input.is_action_just_pressed("shoot_default") and shoot_state == false and _shoot_state == true:
		
		var player_position = Vector3($proximity_area.global_position.x, 0, $proximity_area.global_position.z)
		var obj_enemy = Vector3(enemy_detected.global_position.x, 0, enemy_detected.global_position.z)
		var d = player_position.distance_to(obj_enemy)	
		
		if d < 0.38:
			look_at(obj_enemy, Vector3(Vector3.UP.x, 0.1, Vector3.UP.z))
		if d < 0.1:
			player_anim = 'shoot'
			if typeof(enemy_detected) == 24:
				enemy_detected.healt -= 25
				enemy_detected._break = true
		
		player_status = animation_player["parameters/player_state/current_state"]
		shoot_state = true
	
		var random = randi_range(0, 1)

		if random == 1:
			if animation_player["parameters/player_state/current_state"] != 'punch':
				animation_player["parameters/player_state/transition_request"] = "punch"	
		else:
			if animation_player["parameters/player_state/current_state"] != 'head_attack':
				animation_player["parameters/player_state/transition_request"] = "head_attack"	
		
		$timers/default_shoot.start()
	
	
	if $timers/fatality.is_stopped() and active_fatality == true:
		active_fatality = false
		if get_tree().root.get_children()[0].fatality1 > 0:
			if $timers/fatality_dec.is_stopped():
				if active_fatality_b == true:
					get_tree().root.get_children()[0].fatality2 -= 1
					active_fatality_b = false
				else:
					get_tree().root.get_children()[0].fatality1 -= 1
				
				$timers/fatality_dec.start()
		if typeof(enemy_detected) == 24:
			pass
		$timers/default_shoot.set("wait_time", 0.25)
		$timers/fatality.set("wait_time", 0.258)
		$timers/fatality_dec.set("wait_time", 1.38)
	
	if $timers/default_shoot.is_stopped() and shoot_state == true:
		
		if typeof(enemy_detected) == 24:
			if enemy_detected.disabled_obj == true:
				enemy_detected.disabled_obj = false
				
		shoot_state = false
		rotation.x = 0.0
		animation_player["parameters/player_state/transition_request"] = player_status

func jump():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		stop_sfx(sfx)
		
func camera_rotation(delta):
	
	if Input.is_action_pressed("camera_left"):
		CAMERA_CONTROLLER.rotation.z = 0.0
		#CAMERA_CONTROLLER.rotation.y += 2.68*delta
		rotation.y = lerp(rotation.y, rotation.y+8.08*delta, 0.48)
		
	if Input.is_action_pressed("camera_right"):
		CAMERA_CONTROLLER.rotation.z = 0.0
		#CAMERA_CONTROLLER.rotation.y -= 2.68*delta
		rotation.y = lerp(rotation.y, rotation.y-8.08*delta, 0.48)
		
		
	
	if Input.is_action_pressed("camera_up"):
		if CAMERA_CONTROLLER.rotation.x < 0.238:
			CAMERA_CONTROLLER.rotation.z = 0.0
			CAMERA_CONTROLLER.rotation.x = lerp(CAMERA_CONTROLLER.rotation.x, CAMERA_CONTROLLER.rotation.x+3.36*delta, 0.48)
		
	if Input.is_action_pressed("camera_down"):
		if CAMERA_CONTROLLER.rotation.x > -0.56:
			CAMERA_CONTROLLER.rotation.z = 0.0
			CAMERA_CONTROLLER.rotation.x = lerp(CAMERA_CONTROLLER.rotation.x, CAMERA_CONTROLLER.rotation.x-3.36*delta, 0.48)
func camera_zoom():
	
	var fov = CAMERA_CONTROLLER.get("fov")
	if Input.is_action_pressed("camera_zoom"):
		CAMERA_CONTROLLER.set("fov", 68)
	else:
		if fov < 100:
			CAMERA_CONTROLLER.set("fov", 100)
func idle():
	
	
	if Input.is_action_pressed("up") or Input.is_action_pressed("down") or Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		pass
	else:
		if animation_player["parameters/player_state/current_state"] != 'idle':
			animation_player["parameters/player_state/transition_request"] = "idle"	
func walking():

	var enable = false
	if Input.is_action_pressed("up"):
		enable = true;
	if Input.is_action_pressed("down"):
		enable = true;
	if Input.is_action_pressed("left"):
		enable = true;
	if Input.is_action_pressed("right"):
		enable = true;

	if enable:
		
		if SPEED == 2.0:
			if animation_player["parameters/player_state/current_state"] != 'walking':
					animation_player["parameters/player_state/transition_request"] = "walking"			
		else:
			if animation_player["parameters/player_state/current_state"] != 'running':
				animation_player["parameters/player_state/transition_request"] = "running"	
		if Input.is_action_pressed("sprint"):
			SPEED = 3.68
			player_anim = 'running'
		else:
			SPEED = 1.68
			player_anim = 'walking'
			
		if not Input.is_action_pressed("sprint"):
			
			SPEED = 1.68
		
		var input_dir = Input.get_vector( "left", "right", "up", "down",)
		var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		

		
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED

		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)	
	else:
		var direction = (transform.basis * Vector3(global_position.x, 0, global_position.y)).normalized()
		SPEED = 0.0
		player_anim = 'idle'
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED

func player_sfx():
	
	if player_anim == 'walking':
		if is_on_floor():
			if player_anim != 'walking':
				stop_sfx(sfx)
			play_sfx(sfx, 0)
	if player_anim == 'running':
		if is_on_floor():	
			if player_anim != 'running':
				stop_sfx(sfx)
			play_sfx(sfx, 1)
	
	if player_anim == 'shoot':
		if is_on_floor():	
			if player_anim != 'shoot':
				stop_sfx(sfx)
			play_sfx(sfx, 2)
	if player_anim == 'idle':
		stop_sfx(sfx)

func play_sfx(array, id):
	if not array[id].get("playing"):
		array[id].set("volume_db", -48.0)
		
		array[id].set("playing", true)

func stop_sfx(array):
	var i = 0
	var c = array.size()-1
	
	while i <= c:
		if array[i].get("playing"):
			array[i].set("volume_db", -80.0)
			array[i].set("playing", false)
		i+=1


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

func reset_ini():
	var dificulty = get_tree().root.get_children()[0].dificulty
	var diff = 0
	if dificulty == 'hard':
		diff = 1
	
	var link = "res://settings.ini"
	var file = FileAccess.open(link,FileAccess.WRITE_READ)
	var data = str('0;0;100;0;0;0;0;0;', diff, ';0;0;0;0;0')
	file.store_string(data)
	file.close()

func write_ini():
	var link = "res://settings.ini"
	var file = FileAccess.open(link,FileAccess.READ_WRITE)
	var diff = 1
	
	var dificulty = get_tree().root.get_children()[0].dificulty
	
	if dificulty == 'easy':
		diff = 0
	var _caps = get_tree().root.get_children()[0].caps
	var _score = get_tree().root.get_children()[0].score
	var _healt = get_tree().root.get_children()[0].healt
	var _med_kit = get_tree().root.get_children()[0].med_kit
	var _extra_time = get_tree().root.get_children()[0].extra_time
	var _imunity = get_tree().root.get_children()[0].imunity
	var _fatality1 = get_tree().root.get_children()[0].fatality1
	var _fatality2 = get_tree().root.get_children()[0].fatality2
	var _level_1_easy_end = get_tree().root.get_children()[0].level_1_easy_end
	var _level_1_hardest_end = get_tree().root.get_children()[0].level_1_hardest_end
	var _level_2_hardest_end = get_tree().root.get_children()[0].level_2_hardest_end
	var _level_3_hardest_end = get_tree().root.get_children()[0].level_3_hardest_end
	
	var data = str(_caps, ';', _score, ';', _healt, ';', _med_kit, ';', _extra_time, ';', _imunity, ';', _fatality1, ';', _fatality2, ';', diff, ';', _level_1_easy_end, ';', _level_1_hardest_end, ';', _level_2_hardest_end, ';', _level_3_hardest_end)
	file.store_string(data)
	file.close()


func time_adder(_str):
	_str = var_to_str(_str)
	if len(_str) == 1:
		_str = '0'+_str
		return _str
	else:
		return _str
		
func seconds_to_time(seconds):

	var _min = str(float(match_time)/60.0).split('.')
	_min = int(_min[0])
	
	var __min = time_adder(_min)
	var sec = seconds-(_min*60)
	sec = time_adder(sec)
	return __min+':'+sec

func _on_runtime_timeout():
	if get_tree().root.get_children()[0].paused == false:
		if get_tree().root.get_children()[0].game_resume == true and _exit == false:
			if match_time >= 0:
				update_topbar(true, seconds_to_time(match_time))
				match_time -= 1


func _on_invincibility_timeout():
	if get_tree().root.get_children()[0].paused == false:
		if invincibility_time > 0:
			invincibility_time -= 1
			if $RootNode/Skeleton3D/BoneAttachment3D2/shield.visible == false:
				
				$RootNode/Skeleton3D/BoneAttachment3D2/shield.visible = true
			if _invincibility == false:
				_invincibility = true
		if invincibility_time <= 0:
			if $RootNode/Skeleton3D/BoneAttachment3D2/shield.visible == true:
				
				$RootNode/Skeleton3D/BoneAttachment3D2/shield.visible = false
			if _invincibility == true:
				_invincibility = false
func disable_enemy_collision(obj):
	if obj != null:
		var array = obj.get_children()
		var i = 1
		var c = array.size()-1
		var obj_name = ''
		
		while i<= c:
			obj_name = array[i].name.split('_')[0]
			if obj_name == 'collision':
				array[i].set("disabled", true)
			
			i=i+1
func enable_enemy_collision(obj):
	if obj != null:
		var array = obj.get_children()
		var i = 1
		var c = array.size()-1
		var obj_name = ''
		
		while i<= c:
			obj_name = array[i].name.split('_')[0]
			if obj_name == 'collision':
				array[i].set("disabled", false)
			
			i=i+1


func _on_destroy_enemy_timeout():
	var array = catch.get_children()
	var i = 0
	var c = array.size()-1
	var _name = ''
	var id = ''
	var _array = []
	
	while i <= c:
		
		if array[i] != null:
			_name = array[i].name
			_array = _name.split('_')
			id = str('wall_', _array[1])
			disable_wall(id)

			get_tree().root.get_children()[0].score +=1
			update_topbar()	
			array[i].queue_free()
			$timers/add_skill_card.start()
		i=i+1 
func disable_wall(id):

	var w = walls.get_children()
	var i = 0
	var c = w.size()-1
	
	while i<=c:
		if id == w[i].name:
			w[i].queue_free()
			break
		i+=1


func _on_add_skill_card_timeout():
	#get_tree().root.get_children()[0].score +=1
	#update_topbar()
	var id = player_random_skills[randi_range(0, player_random_skills.size()-1)]
	var obj = skills[id].instantiate()
	var temp = str(obj.name, '_', letters[randi_range(0, letters.size()-1)], letters[randi_range(0, letters.size()-1)], letters[randi_range(0, letters.size()-1)], text_adder(randi_range(1, 99999999), 8))
	obj.name = temp

	ability_cards.add_child(obj)
	var count = ability_cards.get_children().size()-1

	ability_cards.get_children()[count].global_position = Vector3(temp_enemy_location.x, -0.138, temp_enemy_location.z)


func _on_game_over_exit_timeout():
	if $sfx/game_over.get("playing") == false:
		var MainMenu = get_tree().root.get_children()[0].get_children()[2]
		MainMenu.exit_to_menu = true 


func _on_level_complete_exit_timeout():
	if $sfx/unlock_level_.get("playing") == false:
		var MainMenu = get_tree().root.get_children()[0].get_children()[2]
		MainMenu.exit_to_menu = true


func _on_level_complete_exit_2_timeout():
	if $sfx/game_finished.get("playing") == false:
		
		var MainMenu = get_tree().root.get_children()[0].get_children()[2]
		MainMenu.exit_to_menu = true


func _on_level_complete_exit_3_timeout():
	if $sfx/game_resume.get("playing") == false:
		var MainMenu = get_tree().root.get_children()[0].get_children()[2]
		MainMenu.exit_to_menu = true
