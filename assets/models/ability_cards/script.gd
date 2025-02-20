extends Node3D
@onready var player = $"../../player"



# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	loop_rotation()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var _delta = delta
	add_card()
	loop_rotation()
	pass
func add_card():
	var d = _get_distance()
	if d < 0.1:
		var _name = _get_name()
		if _name == 'Caps10':
			player.Caps_10 = true
			get_tree().root.get_children()[0].caps +=10
			update_topbar()
			queue_free()
		if _name == 'Caps100':
			player.Caps_100 = true
			get_tree().root.get_children()[0].caps +=100
			update_topbar()
			queue_free()	
		if _name == 'Caps1000':
			player.Caps_1000 = true
			get_tree().root.get_children()[0].caps +=1000
			update_topbar()
			queue_free()		
		if _name == 'ExtendTime':
			player.extra_time_added_sound = true
			get_tree().root.get_children()[0].extra_time +=1
			update_topbar()
			queue_free()
		if _name == 'FatalityA':
			player.fatalitiy_added_sound = true
			get_tree().root.get_children()[0].fatality1 +=1
			update_topbar()
			queue_free()
		if _name == 'FatalityB':
			player.fatalitiy_added_sound = true
			get_tree().root.get_children()[0].fatality2 +=1
			update_topbar()
			queue_free()
		
		if _name == 'Invincibility':
			player.invincibility_added_sound = true
			get_tree().root.get_children()[0].imunity +=1
			update_topbar()
			queue_free()
		
		if _name == 'MedKit':
			player.med_kit_added_sound = true
			get_tree().root.get_children()[0].med_kit +=1
			update_topbar()
			queue_free()
func _get_name():
	var array = name.split('_')
	return array[0]
func _get_distance():
	var d = Vector3(global_position.x, 0, global_position.z).distance_to(Vector3(player.global_position.x, 0, player.global_position.z))
	return d
func loop_rotation():
	rotation.y = lerp(rotation.y, rotation.y+deg_to_rad(10), 0.1)

func update_topbar(_time = false, time_value = '00:00'):
	var statistics = get_tree().root.get_children()[0].get_children()[1].get_children()[0].get_children()[5]
	if _time == false:
		
		var caps = statistics.get_children()[0]
		var healt = statistics.get_children()[1]
		var score = statistics.get_children()[2] 
		
		
		var med_kit = get_tree().root.get_children()[0].get_children()[1].get_children()[0].get_children()[0].get_children()[0]
		var extra_time = get_tree().root.get_children()[0].get_children()[1].get_children()[0].get_children()[1].get_children()[0]
		var imunity = get_tree().root.get_children()[0].get_children()[1].get_children()[0].get_children()[2].get_children()[0]
		var fatality1 = get_tree().root.get_children()[0].get_children()[1].get_children()[0].get_children()[3].get_children()[0]
		var fatality2 = get_tree().root.get_children()[0].get_children()[1].get_children()[0].get_children()[4].get_children()[0]
		
		score.text = text_adder(get_tree().root.get_children()[0].score, 8)
		caps.text = text_adder(get_tree().root.get_children()[0].caps, 8)
		healt.text = str(get_tree().root.get_children()[0].healt)
		med_kit.text = str(get_tree().root.get_children()[0].med_kit)
		extra_time.text = str(get_tree().root.get_children()[0].extra_time)
		imunity.text = str(get_tree().root.get_children()[0].imunity)
		fatality1.text = str(get_tree().root.get_children()[0].fatality1)
		fatality2.text = str(get_tree().root.get_children()[0].fatality2)
	else:
		var time = statistics.get_children()[3]
		time.text = time_value
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
