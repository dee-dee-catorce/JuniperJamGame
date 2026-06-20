extends Node

#exports

@export
var speed: float = 0
@export
var acceleration: float = 1000 + Globals.accelerationUp
@export
var maxspeed: float = 10000 + Globals.speedUpgrade
@export
var body: RigidBody2D
@export
var driftsound: AudioStreamPlayer2D

enum states {

	idle,
	driving,
	drift,

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
	pass


func _process(delta: float) -> void:
	target = body.get_global_mouse_position()
	direction = body.global_position.direction_to(target)
	distance = body.global_position.distance_to(target)

	angleTarget = direction.angle()


	difference = minPosAngleDiff(angleTarget, body.rotation)

	if Input.is_action_pressed("click"):
		switch(states.driving)
	else:
		switch(states.idle)

	statephy()
	if drifting != driftdb:
		driftsound.pitch_scale = randf_range(.8, 1.1)
		driftsound.playing = drifting
		driftdb = drifting


	driftsound.volume_db = + body.angular_velocity * 1.5
	driftsound.volume_db = clamp(driftsound.volume_db, -1, 0)
	pass

#initial switch
func switch(newstate: states):
	if newstate == currentstate: if Globals.devMode:
		return
	currentstate = newstate
	match states:
		states.idle:
			if Globals.devMode: print("entered idle")

		states.driving:
			if Globals.devMode: print("entered driving")


#physics process

func statephy():
	match currentstate:
		states.idle:
			if Globals.devMode: print("idle physics")


		states.driving:
			if Globals.devMode:
				print("driving physics")
				#print(target)
			var force = direction * acceleration
			body.apply_central_force(force)
			body.apply_torque(difference * body.linear_velocity.length() * 10)


			drifting = abs(body.angular_velocity) > 1.75
				
				
			#body.rotation = direction.angle()
###### helpers
#unity thing
func minPosAngleDiff(target: float, current: float) -> float:
	return atan2(sin(target - current), cos(target - current))
