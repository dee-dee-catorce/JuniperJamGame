extends Camera2D

@export var player: RigidBody2D
@export var max_offset: float = 150.0
@export var lerp_speed: float = 5.0
@export var influence_radius: float = 500.0
@export var targSize = .5

func _ready() -> void:
	print(Saveloadsys.settings["spin"])
	zoom = Vector2(4, 4)
	pass
func _process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	var to_mouse = mouse_pos - player.global_position
	var distance_factor = clamp(to_mouse.length() / influence_radius, 0.0, 1.0)
	var mouse_offset = to_mouse.normalized() * distance_factor * max_offset
	var target = player.global_position + mouse_offset
	global_position = global_position.lerp(target, lerp_speed * delta)

	var speedzoom = abs(player.linear_velocity.length()) / 2000
	targSize = .5 - speedzoom
	targSize = clamp(targSize, .3, .5)
	zoom = lerp(zoom, Vector2(targSize, targSize), .02)

	rotation = player.rotation

	ignore_rotation = !Saveloadsys.settings["spin"]
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("r"):
		get_tree().reload_current_scene()
	pass
