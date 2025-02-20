extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var _delta = delta
	loop_rotation()
func loop_rotation():
	rotation.y = lerp(rotation.y, rotation.y+deg_to_rad(10), 0.1)
