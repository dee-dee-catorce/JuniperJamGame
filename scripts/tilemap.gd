extends TileMap


var fastnoise := FastNoiseLite.new()
func _ready() -> void:
	fastnoise.noise_type = FastNoiseLite.TYPE_SIMPLEX_SMOOTH
	fastnoise.seed = randi()
	randomize()
	#fastnoise.frequency = randf()
	
	generateNoise()


	pass


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("r"):
		get_tree().reload_current_scene()
	pass
func generateNoise():
	for x in 200:
		for y in 100:
			var noiseval = fastnoise.get_noise_2d(x, y)
			print(noiseval)
			if noiseval < 0.24:
				set_cell(0, Vector2i(x, y), 0, Vector2(4, 14))
			else:
				set_cell(0, Vector2i(x, y), 0, Vector2(1, 14))
	pass