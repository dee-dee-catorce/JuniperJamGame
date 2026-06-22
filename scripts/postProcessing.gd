extends CanvasLayer

@export var fog: ColorRect
@export var sound: AudioStreamPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signalbus.timerUpd.connect(timerupd)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func timerupd(timer: int):
	if timer > -1:
		var tween := create_tween()
		var targetrad = (1.0 / (float(timer) / 8))
		tween.tween_property(fog.material, "shader_parameter/radius", targetrad, .5)
		var tween2 := create_tween()
		tween2.tween_property(sound, "volume_db", -timer, .5)
		

		#it took my ears being destroyed for me to add this

		sound.volume_db = clamp(sound.volume_db, -INF, 1.5)

	else:
		var tween := create_tween()
		var targetrad = (1.0 / (float(timer) / 8))
		tween.tween_property(fog.material, "shader_parameter/radius", 1, .0)
		Globals.dead = true
		#fog.material.set_shader_parameter("transparency",1)
		get_tree().change_scene_to_file("res://scenes/death.tscn")
	pass
	#rad = 1 / timer
