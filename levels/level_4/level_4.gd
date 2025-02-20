extends Node3D

var time = 224
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	ambience_sound(delta)
	
func ambience_sound(delta):
	time =  time-delta
	
	if time < 1.8:
		time = 224+1.8
		$sfx/AudioStreamPlayer2.set("volume_db", 14.68)
		$sfx/AudioStreamPlayer2.play()
		$timers/ambience2.start()
	if $timers/ambience2.is_stopped():
		if $sfx/AudioStreamPlayer2.get("playing") == true:
			$sfx/AudioStreamPlayer2.set("volume_db", -80)
			$sfx/AudioStreamPlayer2.stop()
	if $timers/ambience.is_stopped():
		$sfx/AudioStreamPlayer.set("volume_db", -80)
		$sfx/AudioStreamPlayer.stop()
		$sfx/AudioStreamPlayer.set("volume_db", 14.68)
		$sfx/AudioStreamPlayer.play()
		$timers/ambience.start()
		
	else:
		if $timers/ambience.is_stopped():
			$sfx/AudioStreamPlayer.play()


