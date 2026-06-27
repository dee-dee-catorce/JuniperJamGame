extends Node

var devMode = false

var speedUpgrade: int
var accelerationUp: int = -1
var timeup: int
var speedcap: float = 150.00
var dead = false

var earnings: int = 0
var currtrack = 0
func _ready() -> void:
	await get_tree().process_frame
	
	if Saveloadsys.data.has("currspeed"):
		speedUpgrade = Saveloadsys.data["currspeed"]
		print("found speed data")
	else:
		speedUpgrade = 0
		print("failed speed data")
	if Saveloadsys.data.has("currtimeadd"):
		timeup = Saveloadsys.data["currtimeadd"]
	else:
		timeup = 0


func freeze_frame(time_scale: float, duration: float):
	Engine.time_scale = time_scale
	await get_tree().create_timer(duration, true, false, true).timeout
	Engine.time_scale = 1.0