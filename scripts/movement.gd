extends Node

#exports

@export
var speed: float = 0
@export
var acceleration: float = 1000
@export
var maxspeed: float = 10000 + Globals.speedUpgrade
@export
var body: RigidBody2D
@export
var driftsound: AudioStreamPlayer2D
@export
var accel: AudioStreamPlayer2D
enum states {

	idle,
	driving,
	backup,

}
#not exported variables
var currentstate = states.idle
var target: Vector2
var direction
var distance: float
var angleTarget
var difference
var drifting = false


var driftdb = false
func _ready() -> void:
	if Globals.devMode: print("initialized")

	accel.pitch_scale = 1
	pass


func _process(delta: float) -> void:
	target = body.get_global_mouse_position()
	direction = body.global_position.direction_to(target)
	distance = body.global_position.distance_to(target)

	angleTarget = direction.angle()


	difference = minPosAngleDiff(angleTarget, body.rotation)

	if Input.is_action_pressed("click"):
		switch(states.driving)
	elif Input.is_action_pressed("rclick"):
		switch(states.backup)
	else:
		switch(states.idle)

	statephy(delta)
	if drifting != driftdb:
		driftsound.pitch_scale = randf_range(.8, 1.1)
		driftsound.playing = drifting
		driftdb = drifting

	accel.pitch_scale = (abs(body.linear_velocity.length()) / 1000) + .1
	accel.pitch_scale = clamp(accel.pitch_scale, .51, 3.51)
	driftsound.volume_db = + body.angular_velocity * 1.5
	driftsound.volume_db = clamp(driftsound.volume_db, -1, 0)
	pass

#initial switch
func switch(newstate: states):
	if newstate == currentstate: if Globals.devMode:
		return
	currentstate = newstate
	match currentstate:
		states.idle:
			if Globals.devMode: print("entered idle")

		states.driving:
			if Globals.devMode: print("entered driving")


#physics process

func statephy(delta):
	match currentstate:
		states.idle:
			if Globals.devMode: print("idle physics")


		states.driving:
			if Globals.devMode:
				print("driving physics")
				#print(target)
			var force = direction * (acceleration + Saveloadsys.data.get("currspeed", 0) * 100)
			body.apply_central_force(force * delta * 100)
			#body.apply_torque(200009)
			body.apply_torque(difference * body.linear_velocity.length() * 10)

			drifting = abs(body.angular_velocity) > 1.75
				
		states.backup:
			if Globals.devMode:
				print("backup physics")
				#print(target)
			var force = direction * (acceleration + Saveloadsys.data.get("currspeed", 0) * 100)
			body.apply_central_force((-force * delta * 100) / 3)
			#body.apply_torque(200009)
			body.apply_torque(difference * body.linear_velocity.length() * 10)

			drifting = abs(body.angular_velocity) > 1.75
								
			#body.rotation = direction.angle()
###### helpers
#unity thing
func minPosAngleDiff(target: float, current: float) -> float:
	return atan2(sin(target - current), cos(target - current))


func nm(value: float, min_val: float, max_val: float) -> float:
	if min_val == max_val:
		return 0.0
	return (value - min_val) / (max_val - min_val)
