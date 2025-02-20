extends ProgressBar
@export var scene = 'none'
@export var enabled = false
@onready var progress_bar = $"."

var play_game = false
var runtime = false

var progress = []
var scene_load_status = 0
var _scene = ''
var res_scene = ''

func load_scene():
	_scene = scene
	ResourceLoader.load_threaded_request(scene)
func wait(duration):  
	await get_tree().create_timer(duration, false, false, true).timeout
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var _delta = delta
	if enabled:
		
		load_scene()
		enabled = false
		runtime = true
	if runtime:
		#print(_scene)
		scene_load_status = ResourceLoader.load_threaded_get_status(scene, progress)
		progress_bar.value = progress[0] * 100
		if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
			res_scene = ResourceLoader.load_threaded_get(scene)
			runtime = false
			play_game = true
			$Wait.start()
	if $Wait.is_stopped() and play_game == true:
		$"../..".game_resume = true
		play_game = false
		$"..".visible = false
		visible = false
		$"../../sfx/AudioStreamPlayer".stop()

		get_tree().root.add_child(res_scene.instantiate())
		res_scene = ''			
