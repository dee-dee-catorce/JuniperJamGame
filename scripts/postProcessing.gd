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
	if timer != 0:
		var tween := create_tween()
		var targetrad = (1.0 / (float(timer) / 8))
		tween.tween_property(fog.material, "shader_parameter/radius", targetrad, 1.5)
		var tween2 := create_tween()
		tween2.tween_property(sound, "volume_db", -timer, 1.5)
	pass
	#rad = 1 / timer
