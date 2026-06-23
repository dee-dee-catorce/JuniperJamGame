extends Node2D

@export var handNode: Node2D
@export var top: Node2D
@export var bottom: Node2D
@export var sprite: Sprite2D

@export var stiffness: float = 200.0
@export var damping: float = 15.0

var offset: Vector2
var velocity: Vector2 = Vector2.ZERO
var weight: float = .5
var end = false

func _ready() -> void:
	pass
	

func _process(delta: float) -> void:
	if end:
		velocity.y += 1200 * delta # gravity
		top.position += velocity * delta
		sprite.position = top.position

		return

	if Input.is_action_pressed("click"):
		sprite.frame = 1
	else:
		sprite.frame = 0

	var tPos = get_global_mouse_position() + offset
	var displacement = top.position - tPos
	var force = (-stiffness * displacement) - (damping * velocity)
	velocity += force * delta
	top.position += velocity * delta

	sprite.rotation = sprite.rotation + (velocity.x / 15000.0)
	sprite.rotation = lerp(sprite.rotation, 0.0, weight)
	sprite.position = top.position

	weight = lerp(weight, 0.5, .01)
	offset = lerp(offset, Vector2.ZERO, .1)
