extends Node


@export var timer: int
@export var label: RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timeloop()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#recycled
func intTime(total_seconds: int) -> String:
	# Calculate hours, minutes, and remaining seconds
	var hours: int = total_seconds / 3600
	var minutes: int = (total_seconds % 3600) / 60
	var seconds: int = total_seconds % 60
	
	if hours > 0:
		return "%02d:%02d:%02d" % [hours, minutes, seconds]
	else:
		return "%02d:%02d" % [minutes, seconds]

func timeloop():
	while true:
		timer -= 1
		label.text = "[wave]" + intTime(timer)
		Signalbus.updateTimer(timer)
		await get_tree().create_timer(1).timeout


func nudgetimer():
	var tween := create_tween()
	
	pass