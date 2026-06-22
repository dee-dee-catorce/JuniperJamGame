extends Node

#exports

@export
var speed: float = 1000
@export
var acceleration: float = 1000 + Globals.accelerationUp
@export
var spr: Sprite2D
@export
var body: RigidBody2D
@export
var accel: AudioStreamPlayer2D
enum states {

	idle,
	moving,

}
#not exported variables
var currentstate = states.idle
var direction: Vector2
var looktar: Vector2
var lookdir
var angleTarget
var difference
var driftdb = false
func _ready() -> void:
	if Globals.devMode: print("initialized")


	step()
	#accel.pitch_scale = 1
	pass
func step():
	while get_tree():
		if currentstate == states.moving:
			accel.playing = true
		else:
			accel.playing = false
		await get_tree().create_timer(.3).timeout

func _process(delta: float) -> void:
	direction = Input.get_vector("left", "right", "up", "down")
	
	looktar = body.get_global_mouse_position()
	lookdir = body.global_position.direction_to(looktar)

	angleTarget = lookdir.angle()

	difference = minPosAngleDiff(angleTarget, body.rotation)
	if direction != Vector2.ZERO:
		switch(states.moving)

	else:
		switch(states.idle)
	spr.look_at(body.get_global_mouse_position())
	#body.apply_torque(difference * 400)
	pass
func _physics_process(delta: float) -> void:
	statephy()
	pass
#initial switch
func switch(newstate: states):
	if newstate == currentstate:
		return
	currentstate = newstate
	match currentstate:
		states.idle:
			if Globals.devMode: print("entered idle")

		states.moving:
			if Globals.devMode: print("entered driving")


#physics process

func statephy():
	match currentstate:
		states.idle:
			if Globals.devMode: print("idle physics")


		states.moving:
			if Globals.devMode: print("move physics")
			print(direction)
			body.apply_central_force(direction * speed)

			
			pass
				
			#body.rotation = direction.angle()
###### helpers
#unity thing
func minPosAngleDiff(target: float, current: float) -> float:
	return atan2(sin(target - current), cos(target - current))


func nm(value: float, min_val: float, max_val: float) -> float:
	if min_val == max_val:
		return 0.0
	return (value - min_val) / (max_val - min_val)
