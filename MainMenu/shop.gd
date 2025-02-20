extends Control

var arrow = load("res://assets/textures/mouse_cursor/arrow.png")
var pointer = load("res://assets/textures/mouse_cursor/pointer.png")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("shop"):
		if $"..".level_selected == 'level_4':
			$"..".paused = true
			visible = true
			if Input.mouse_mode != Input.MOUSE_MODE_VISIBLE:
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			$"../sfx/AudioStreamPlayer2".play()
		else:
			$"../sfx/AudioStreamPlayer3".play()


func _on_close_mouse_entered():
	Input.set_custom_mouse_cursor(pointer)


func _on_close_mouse_exited():
	Input.set_custom_mouse_cursor(arrow)


func _on_close_pressed():
	$"..".paused = false
	visible = false


func _on_texture_button_mouse_entered():
	Input.set_custom_mouse_cursor(pointer)


func _on_texture_button_mouse_exited():
	Input.set_custom_mouse_cursor(arrow)


func _on_med_kit_pressed():
	if $"..".caps > 2800:
		$"..".caps -= 2800
		$"..".med_kit += 1
		$"..".UpdateTopBar = true
		$"../sfx/AudioStreamPlayer2".play()
	else:
		$"../sfx/AudioStreamPlayer3".play()
	
	


func _on_med_kit_mouse_entered():
	Input.set_custom_mouse_cursor(pointer)


func _on_med_kit_mouse_exited():
	Input.set_custom_mouse_cursor(arrow)


func _on_extratime_pressed():
	if $"..".caps > 4000:
		$"..".caps -= 4000
		$"..".extra_time += 1
		$"..".UpdateTopBar = true
		$"../sfx/AudioStreamPlayer2".play()
	else:
		$"../sfx/AudioStreamPlayer3".play()


func _on_extratime_mouse_entered():
	Input.set_custom_mouse_cursor(pointer)


func _on_extratime_mouse_exited():
	Input.set_custom_mouse_cursor(arrow)


func _on_fatality_a_pressed():
	if $"..".caps > 4000:
		$"..".caps -= 4000
		$"..".fatality1 += 1
		$"..".UpdateTopBar = true
		$"../sfx/AudioStreamPlayer2".play()
	else:
		$"../sfx/AudioStreamPlayer3".play()


func _on_fatality_a_mouse_entered():
	Input.set_custom_mouse_cursor(pointer)
func _on_fatality_a_mouse_exited():
	Input.set_custom_mouse_cursor(arrow)

func _on_fatality_b_pressed():
	if $"..".caps > 4000:
		$"..".caps -= 4000
		$"..".fatality2 += 1
		$"..".UpdateTopBar = true
		$"../sfx/AudioStreamPlayer2".play()
	else:
		$"../sfx/AudioStreamPlayer3".play()

func _on_fatality_b_mouse_entered():
	Input.set_custom_mouse_cursor(pointer)


func _on_fatality_b_mouse_exited():
	Input.set_custom_mouse_cursor(arrow)


func _on_invincibility_pressed():
	if $"..".caps > 10000:
		$"..".caps -= 10000
		$"..".imunity += 1
		$"..".UpdateTopBar = true
		$"../sfx/AudioStreamPlayer2".play()
	else:
		$"../sfx/AudioStreamPlayer3".play()


func _on_invincibility_mouse_entered():
	Input.set_custom_mouse_cursor(pointer)


func _on_invincibility_mouse_exited():
	Input.set_custom_mouse_cursor(arrow)
