extends Node


@export var timer: int = 10220
@export var label: RichTextLabel
@export var sound: AudioStreamPlayer2D
@export var sound2: AudioStreamPlayer2D
@export var sound3: AudioStreamPlayer2D
@onready
var lTarget = label.offset_transform_position.y
var started = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#timeloop()
	Signalbus.updateTimer(timer)
	Signalbus.button.connect(sign)
	Signalbus.start.connect(timeloop)
	pass # Replace with function body.


var runstarts = [

	">:#",
	">:)",
	"Have fun!",
	"GO GO GO!!!!",
	"Safe travels!",
	"Happy driving!",
	"Slower this time!",
	"This time you'll get it!",
	"Are we there yet? Are we there yet? Are we there yet? Are we there yet? Are we there yet? Are we there yet?",
	"You drive like a grandma!",
	"Don't forget your seat belt!",
	"By the way, you die if that timer hits zero.",
	"Faster this time!",
	"Hint: You can drive by clicking LMB",
	"O/U 1:00?"

]

var byes = [
	"Maybe next time!...",
	"Too slow...",
	"You're taking too long!",
	"Times up!",
	"Bye bye!",
	
]

#recycled
func intTime(total_seconds: int) -> String:
	# Calculate hours, minutes, and remaining seconds
	var hours: int = total_seconds / 3600
	var minutes: int = (total_seconds % 3600) / 60
	var seconds: int = total_seconds % 60
	if total_seconds <= 0:
		return "[color=red][shake rate=20 level=50]" + byes.pick_random()
	
	if hours > 0:
		return "%02d:%02d:%02d" % [hours, minutes, seconds]
	else:
		return "%02d:%02d" % [minutes, seconds]


func timeloop():
	Globals.dead = false
	while is_inside_tree():
		timer -= 1

		if started == false:
			timer += Saveloadsys.data["currtimeadd"] * 5
			label.text = "[wave amp=20 freq=10]" + runstarts.pick_random()
			sound.play()
			await get_tree().create_timer(.25).timeout
			if not is_inside_tree(): return
			label.visible = true
			await get_tree().create_timer(.5).timeout
			if not is_inside_tree(): return
			label.visible = false

			await get_tree().create_timer(.25).timeout
			if not is_inside_tree(): return
			label.visible = true
			await get_tree().create_timer(.5).timeout
			if not is_inside_tree(): return
			label.visible = false

			await get_tree().create_timer(.25).timeout
			if not is_inside_tree(): return
			label.visible = true
			await get_tree().create_timer(.5).timeout
			if not is_inside_tree(): return
			label.visible = false
			await get_tree().create_timer(.25).timeout
			if not is_inside_tree(): return
			label.visible = true

			started = true
		label.text = "[wave amp=00 freq=0]" + intTime(timer)
		Signalbus.updateTimer(timer)
		nudgetimer()
		if !Globals.dead and is_inside_tree():
			await get_tree().create_timer(1).timeout
			if not is_inside_tree(): return


func nudgetimer():
	if not is_inside_tree(): return
	var tween := create_tween()
	sound2.play()

	label.offset_transform_position.y += 5
	tween.tween_property(label, "offset_transform_position:y", lTarget, .5).set_ease(tween.EASE_OUT)
	pass

func fuckyou(ti: int):
	var total_steps: float = abs(ti)
	
	sound3.play()
	for i in int(total_steps):
		if not is_inside_tree(): return
		var progress: float = float(i) / total_steps
		if not is_inside_tree(): return
		
		sound2.play()
		if ti > 0:
			timer += 1
			label.modulate = Color.WHITE.lerp(Color.GREEN, progress)
		else:
			timer -= 1
			label.modulate = Color.WHITE.lerp(Color.RED, progress)
		
		label.text = "[wave amp=00 freq=0]" + intTime(timer)
		nudgetimer()
		
		await get_tree().create_timer(.05).timeout
	label.modulate = Color.WHITE


func sign(intaa):
	fuckyou(intaa)
	pass # Replace with function body.
