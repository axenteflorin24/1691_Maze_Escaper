extends CharacterBody3D


var SPEED = 5.0
var JUMP_VELOCITY = 1.68


@onready var animation_player = $AnimationTree
@onready var CAMERA_CONTROLLER = $Camera3D
@onready var sfx = [$sfx/foot_steps, $sfx/foot_steps_running, $sfx/shoot]
@onready var raycasts = [$RootNode/Skeleton3D/BoneAttachment3D2/head, $RootNode/Skeleton3D/BoneAttachment3D3/punch, $shoot]
@onready var enemy_array = $"../enemy_array"
@onready var collision = $CollisionShape3D2
@export var healt = 100
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 10.0

var jump_state = false
var shoot_state = false
var _shoot_state = false
var player_status = 'idle'

var player_anim = 'idle'

var camera_state_position = Vector3()
var camera_state_rotation = Vector3()
func _ready():
	collision.set("disabled", true)
	camera_state_position = CAMERA_CONTROLLER.position
	camera_state_rotation = CAMERA_CONTROLLER.rotation
var enemy_detected = []

func _physics_process(delta):
	
	print(healt)
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
	
	
	

	player_sfx()
	
	if shoot_state == false:
		camera_zoom()
		camera_rotation(delta)
		idle()
		walking()
		jump()
	if distance_to_enemy < 0.25:
		_shoot_state = true
	else:
		_shoot_state = false
	
	shoot()
	
	move_and_slide()
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
	if Input.is_action_just_pressed("shoot_default") and shoot_state == false and _shoot_state == true:
		
		var player_position = Vector3($proximity_area.global_position.x, 0, $proximity_area.global_position.z)
		var obj_enemy = Vector3(enemy_detected.global_position.x, 0, enemy_detected.global_position.z)
		var d = player_position.distance_to(obj_enemy)	
		
		if d < 0.38:
			look_at(obj_enemy, Vector3(Vector3.UP.x, 0.1, Vector3.UP.z))
		if d < 0.1:
			player_anim = 'shoot'
			enemy_detected.healt -= 25
		

		
		
		CAMERA_CONTROLLER.position = Vector3(10.939, 20.465, 12.195)
		CAMERA_CONTROLLER.rotation = Vector3(deg_to_rad(-10.7), deg_to_rad(21.6), deg_to_rad(0))
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
		
	if $timers/default_shoot.is_stopped() and shoot_state == true:
		CAMERA_CONTROLLER.position = camera_state_position
		CAMERA_CONTROLLER.rotation = camera_state_rotation
		shoot_state = false
		
		animation_player["parameters/player_state/transition_request"] = player_status
	



func shoot_b():
	if Input.is_action_just_pressed("shoot_default") and shoot_state == false:
		player_status = animation_player["parameters/player_state/current_state"]
		shoot_state = true
		if animation_player["parameters/player_state/current_state"] != 'head_attack':
			animation_player["parameters/player_state/transition_request"] = "head_attack"	
		$timers/default_shoot.start()
		
	if $timers/default_shoot.is_stopped() and shoot_state == true:
		shoot_state = false
		animation_player["parameters/player_state/transition_request"] = player_status				
func jump():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		stop_sfx(sfx)
		
func camera_rotation(delta):
	
	if Input.is_action_pressed("camera_left"):
		CAMERA_CONTROLLER.rotation.z = 0.0
		#CAMERA_CONTROLLER.rotation.y += 2.68*delta
		rotation.y += 4.08*delta
		
	if Input.is_action_pressed("camera_right"):
		CAMERA_CONTROLLER.rotation.z = 0.0
		#CAMERA_CONTROLLER.rotation.y -= 2.68*delta
		rotation.y -= 4.08*delta
		
		
	if Input.is_action_pressed("camera_up"):
		if CAMERA_CONTROLLER.rotation.x < 0.238:
			CAMERA_CONTROLLER.rotation.z = 0.0
			CAMERA_CONTROLLER.rotation.x += 1.68*delta
		
	if Input.is_action_pressed("camera_down"):
		if CAMERA_CONTROLLER.rotation.x > -0.56:
			CAMERA_CONTROLLER.rotation.z = 0.0
			CAMERA_CONTROLLER.rotation.x -= 1.68*delta
func camera_zoom():
	
	var fov = CAMERA_CONTROLLER.get("fov")
	if Input.is_action_pressed("camera_zoom"):
		CAMERA_CONTROLLER.set("fov", 38)
	else:
		if fov < 68:
			CAMERA_CONTROLLER.set("fov", 68)
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
		array[id].set("volume_db", -18.0)
		array[id].set("playing", true)

func stop_sfx(array):
	var i = 0
	var c = array.size()-1
	
	while i <= c:
		if array[i].get("playing"):
			array[i].set("volume_db", -80.0)
			array[i].set("playing", false)
		i+=1









