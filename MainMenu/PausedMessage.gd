extends Control

var arrow = load("res://assets/textures/mouse_cursor/arrow.png")
var pointer = load("res://assets/textures/mouse_cursor/pointer.png")
# Called when the node enters the scene tree for the first time.
@export var exit_to_menu = false

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var _delta = delta
	if exit_to_menu == true:
		exit_to_menu = false
		exti_to_main_menu()



func _on_resume_pressed():
	
	$"..".paused = false
	$".".set("visible", false)

func _on_resume_mouse_entered():
	Input.set_custom_mouse_cursor(pointer)


func _on_resume_mouse_exited():
	Input.set_custom_mouse_cursor(arrow)


func _on_exit_to_main_menu_pressed():
	exti_to_main_menu()

func _on_exit_to_main_menu_mouse_entered():
	Input.set_custom_mouse_cursor(pointer)


func _on_exit_to_main_menu_mouse_exited():
	Input.set_custom_mouse_cursor(arrow)

func exti_to_main_menu():
	
	$"..".paused = false
	if Input.mouse_mode != Input.MOUSE_MODE_VISIBLE:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	$".".set("visible", false)
	get_tree().root.get_children()[1].queue_free()
	
	var menu = get_tree().root.get_children()[0].get_children()[0]
	var topbar = get_tree().root.get_children()[0].get_children()[1]
	
	menu.visible = true
	menu.get_children()[0].visible = true
	menu.get_children()[1].visible = false
	menu.get_children()[2].visible = true
	menu.get_children()[3].visible = true
	menu.get_children()[4].visible = true
	menu.get_children()[5].visible = true
	menu.get_children()[6].visible = true
	menu.get_children()[7].visible = true
	menu.get_children()[8].visible = true
	menu.get_children()[9].visible = true
	menu.get_children()[10].visible = true
	menu.get_children()[11].visible = true
	menu.get_children()[12].visible = false
	menu.get_children()[13].visible = false
	menu.get_children()[14].visible = true
	topbar.get_children()[0].visible = false
	
	
	$"..".game_resume = false
	$"..".reload = true
