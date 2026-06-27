extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signalbus.start.connect(start)

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func start():
	var rando = randi_range(1, 2)

	if rando == 1:
		$Placeholder.play()
	else:
		$Finalstage.play()
	pass