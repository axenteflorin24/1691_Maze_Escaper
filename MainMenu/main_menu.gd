extends Node3D

@export var level_selected = 'level_1'
@export var game_resume = false
@export var paused = false
@export var caps = 0
@export var score = 0
@export var healt = 100
@export var med_kit = 0
@export var extra_time = 0
@export var imunity = 0
@export var fatality1 = 0
@export var fatality2 = 0
@export var dificulty = 'easy'
@export var UpdateTopBar = false

@export var level_2_enabled = 0
@export var level_3_enabled = 0
@export var level_4_enabled = 0

@export var level_1_easy_end = 0 #9
@export var level_1_hardest_end = 0 #10
@export var level_2_hardest_end = 0 #11
@export var level_3_hardest_end = 0 #12


var arrow = load("res://assets/textures/mouse_cursor/arrow.png")
var pointer = load("res://assets/textures/mouse_cursor/pointer.png")

@export var levels = ["res://levels/level_1/level_1.tscn", "res://levels/level_2/level_2.tscn", "res://levels/level_3/level_3.tscn", "res://levels/level_4/level_4.tscn"]
@export var game_level_link = "res://levels/level_1/level_1.tscn"
@export var reload = false
# Called when the node enters the scene tree for the first time.
func _ready():
	
	if not FileAccess.file_exists("res://settings.ini"):
		reset_ini()
	set_windowed()
	read_ini()
	unlock_levels()
	dificulty_set()
	Input.set_custom_mouse_cursor(arrow)
	visible_all()
	quit_all_texts()
	print_story()

# Called every frame. 'delta' is the elapsed time since the previous frame.
var screen_res = Vector2i(980, 580)

func _input(event):
	if event.is_action_pressed("FullScreen"):
		set_full_screen()
		
		
	if event.is_action_pressed("Windowed"):
		set_windowed()

func _process(delta):
	if reload == true:
		reload = false
		level_selected = 'level_1'
		game_level_link = levels[0]
		level_2_enabled = 0
		level_3_enabled = 0
		level_4_enabled = 0
		read_ini()
		unlock_levels()
		dificulty_set()
	if game_resume == false:
		if Input.mouse_mode != Input.MOUSE_MODE_VISIBLE:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	var _delta = delta
	if Input.is_action_pressed("quit"):
		if $Control/ProgressBar.visible == false and game_resume == true:
			
			paused = true
			
			$PausedMessage.set("visible", true)
	if game_resume == false:
		if $sfx/AudioStreamPlayer.get("playing") == false:
			$sfx/AudioStreamPlayer.play()

func unlock_levels():
	if level_1_easy_end > 0:
		level_2_enabled = 1
		$Control/level_2/padlock.visible = false
	else:
		$Control/level_2/padlock.visible = true
	if level_1_hardest_end > 0 and level_2_hardest_end > 0:
		level_3_enabled = 1
		$Control/level_3/padlock.visible = false	 
	else:
		$Control/level_3/padlock.visible = true
	if level_1_hardest_end > 0 and level_2_hardest_end > 0 and level_3_hardest_end > 0:
		level_4_enabled = 1
		$Control/level_4/padlock.visible = false
	else:
		$Control/level_4/padlock.visible = true

func dificulty_set():
	if dificulty == 'easy':
		$Control/settings_buttons/TextureRect/Label.text = '       Dificulty Selected : Easy'
	else:
		$Control/settings_buttons/TextureRect/Label.text = '       Dificulty Selected : Hard'
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

func read_ini():
	var link = "res://settings.ini"
	var file = FileAccess.open(link,FileAccess.READ_WRITE)
	var data = file.get_as_text()
	file.close()
	var array = data.split(';')
	
	caps = int(array[0])
	score = int(array[1])
	healt = float(array[2])
	
	med_kit = int(array[3])
	extra_time = int(array[4])
	imunity = int(array[5]) 
	fatality1 = int(array[6]) 
	fatality2 = int(array[7]) 
	
	if int(array[8]) == 0:
		dificulty = 'easy'
	else:
		dificulty = 'hard'
	
	level_1_easy_end = int(array[9])
	level_1_hardest_end = int(array[10])
	level_2_hardest_end = int(array[11])	
	level_3_hardest_end = int(array[12])	
	
func write_ini():
	var link = "res://settings.ini"
	var file = FileAccess.open(link,FileAccess.READ_WRITE)
	var diff = 1
	if dificulty == 'easy':
		diff = 0
	
	
	var data = str(caps, ';', score, ';', healt, ';', med_kit, ';', extra_time, ';', imunity, ';', fatality1, ';', fatality2, ';', diff, ';', level_1_easy_end, ';', level_1_hardest_end, ';', level_2_hardest_end, ';', level_3_hardest_end)
	file.store_string(data)
	file.close()
func reset_ini():
	var _dificulty = get_tree().root.get_children()[0].dificulty
	var diff = 0
	if _dificulty == 'hard':
		diff = 1
	
	var link = "res://settings.ini"
	var file = FileAccess.open(link,FileAccess.WRITE_READ)
	var data = str('0;0;100;0;0;0;0;0;', diff, ';0;0;0;0;0')
	file.store_string(data)
	file.close()
func visible_all():
	
	$Control/play.visible = true
	$Control/level_1.visible = true
	$Control/level_2.visible = true
	$Control/level_3.visible = true
	$Control/level_4.visible = true
	$Control/missions.visible = true
	$Control/settings.visible = true
	$Control/quit.visible = true
	$Control/Label.visible = true
	$Control/story.visible = true
	$Control/settings_buttons.visible = true
	$Control/missions_text.visible = true
	$Control/game_title.visible = true

func close_all():
	
	$Control/play.visible = false
	$Control/level_1.visible = false
	$Control/level_2.visible = false
	$Control/level_3.visible = false
	$Control/level_4.visible = false
	$Control/missions.visible = false
	$Control/settings.visible = false
	$Control/quit.visible = false
	$Control/Label.visible = false
	$Control/story.visible = false
	$Control/settings_buttons.visible = false
	$Control/missions_text.visible = false
	$Control/game_title.visible = false

func quit_all_texts():
	
	$Control/story.visible = false
	$Control/missions_text.visible = false
	$Control/settings_buttons.visible = false
	
	
func print_story():
	quit_all_texts()
	$Control/story.visible = true

func _on_play_mouse_entered():
	Input.set_custom_mouse_cursor(pointer)


func _on_play_mouse_exited():
	Input.set_custom_mouse_cursor(arrow)

func _on_level_1_mouse_entered():
	Input.set_custom_mouse_cursor(pointer)


func _on_level_1_mouse_exited():
	Input.set_custom_mouse_cursor(arrow)


func _on_level_2_mouse_entered():
	Input.set_custom_mouse_cursor(pointer)


func _on_level_2_mouse_exited():
	Input.set_custom_mouse_cursor(arrow)


func _on_level_3_mouse_entered():
	Input.set_custom_mouse_cursor(pointer)


func _on_level_3_mouse_exited():
	Input.set_custom_mouse_cursor(arrow)


func _on_level_4_mouse_entered():
	Input.set_custom_mouse_cursor(pointer)


func _on_level_4_mouse_exited():
	Input.set_custom_mouse_cursor(arrow)


func _on_missions_mouse_entered():
	Input.set_custom_mouse_cursor(pointer)


func _on_missions_mouse_exited():
	Input.set_custom_mouse_cursor(arrow)


func _on_settings_mouse_entered():
	Input.set_custom_mouse_cursor(pointer)


func _on_settings_mouse_exited():
	Input.set_custom_mouse_cursor(arrow)


func _on_quit_mouse_entered():
	Input.set_custom_mouse_cursor(pointer)


func _on_quit_mouse_exited():
	Input.set_custom_mouse_cursor(arrow)
	

func _on_play_pressed():
	close_all()
	$Control/ProgressBar.visible = true
	$Control/ProgressBar.scene = game_level_link
	$Control/ProgressBar.enabled = true

func _on_level_1_pressed():
	$Control/Label.set("text", 'level_1')
	level_selected = 'level_1'
	game_level_link = levels[0]

func _on_level_2_pressed():
	if level_2_enabled == 1:
		$Control/Label.set("text", 'level_2')
		level_selected = 'level_2'
		game_level_link = levels[1]

func _on_level_3_pressed():
	if level_3_enabled == 1:
		$Control/Label.set("text", 'level_3')
		level_selected = 'level_3'
		game_level_link = levels[2]

func _on_level_4_pressed():
	if level_4_enabled == 1:
		$Control/Label.set("text", 'level_4')
		level_selected = 'level_4'
		game_level_link = levels[3]

func _on_missions_pressed():
	quit_all_texts()
	$Control/missions_text.visible = true

func _on_settings_pressed():
	quit_all_texts()
	$Control/settings_buttons.visible = true

func _on_quit_pressed():
	get_tree().quit()


func _on_texture_button_mouse_entered():
	Input.set_custom_mouse_cursor(pointer)


func _on_texture_button_pressed():
	quit_all_texts()
	$Control/story.visible = true


func _on_texture_button_mouse_exited():
	Input.set_custom_mouse_cursor(arrow)



func _on_read_story_mouse_entered():
	Input.set_custom_mouse_cursor(pointer)


func _on_read_story_mouse_exited():
	Input.set_custom_mouse_cursor(arrow)


func _on_read_story_pressed():
	quit_all_texts()
	$Control/story.visible = true


func _on_close_settings_mouse_entered():
	Input.set_custom_mouse_cursor(pointer)


func _on_close_settings_mouse_exited():
	Input.set_custom_mouse_cursor(arrow)


func _on_close_settings_pressed():
	quit_all_texts()
	$Control/story.visible = true



func _on_hard_dificulty_mouse_entered():
	Input.set_custom_mouse_cursor(pointer)


func _on_hard_dificulty_mouse_exited():
	Input.set_custom_mouse_cursor(arrow)


func _on_hard_dificulty_pressed():
	dificulty = 'hard'
	$Control/settings_buttons/TextureRect/Label.set("text", "       Dificulty Selected : Hard")
	write_ini()

func _on_easy_dificulty_mouse_entered():
	Input.set_custom_mouse_cursor(pointer)


func _on_easy_dificulty_mouse_exited():
	Input.set_custom_mouse_cursor(arrow)


func _on_easy_dificulty_pressed():
	dificulty = 'easy'
	$Control/settings_buttons/TextureRect/Label.set("text", "       Dificulty Selected : Easy")
	write_ini()
func set_windowed():
	get_window().content_scale_size = screen_res
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	DisplayServer.window_set_size(Vector2i(1280,728))

func set_full_screen():
	get_window().content_scale_size = screen_res
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
