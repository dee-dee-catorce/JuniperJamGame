extends Node
class_name Select

signal hovered
signal unhovered
signal drag_started
signal drag_stopped

@export_group("Outline")
@export var outline_width: int = 3
@export var sprite: Sprite2D

@export_group("Spring Joint")
@export var spring_stiffness: float = 2000.0
@export var spring_damping: float = 105.0
@export var spring_length: float = 0.0

@export_group("Input")
@export var click_action: String = "click"

@export_group("Node References")
@export var detector_name: String = "Detector"
@export var dragger_parent: NodePath = NodePath("")

var _dect: Area2D
var _hovering := false
var _curr_line := 0.0
var _dragging := false
var _dragger: StaticBody2D
var _joint: DampedSpringJoint2D


func _ready() -> void:
	var det_node := get_parent().find_child(detector_name) if detector_name != "" \
			else get_parent().find_child("Detector")
	if det_node is Area2D:
		_dect = det_node
	else:
		push_warning("Select (%s): no Area2D detector found — hover/drag disabled." \
				% get_parent().name)


func _process(_delta: float) -> void:
	if not _dect:
		return

	var mouse_pos := _dect.get_global_mouse_position()

	if _dragging and not Input.is_action_pressed(click_action):
		_stop_drag()
		if not _is_mouse_over(mouse_pos):
			_set_hover(false)

	if _dragging and _dragger:
		_dragger.global_position = mouse_pos

	if not _dragging:
		var now_hovering := _is_mouse_over(mouse_pos)
		if now_hovering and not _hovering:
			_on_enter()
		elif not now_hovering and _hovering:
			_on_exit()

	if _hovering and not _dragging and Input.is_action_just_pressed(click_action):
		_start_drag(mouse_pos)

	var target_line := float(outline_width) if (_hovering or _dragging) else 0.0
	_curr_line = lerp(_curr_line, target_line, 0.5)
	if sprite and sprite.material:
		sprite.material.set_shader_parameter("thickness", _curr_line)


func _start_drag(mouse_pos: Vector2) -> void:
	_dragging = true
	drag_started.emit()

	_dragger = StaticBody2D.new()
	_joint = DampedSpringJoint2D.new()
	_joint.node_a = NodePath("")
	_joint.node_b = NodePath("")
	_dragger.add_child(_joint)

	var parent: Node = get_node_or_null(dragger_parent) \
			if dragger_parent != NodePath("") \
			else get_tree().current_scene
	parent.add_child(_dragger)

	await get_tree().process_frame

	if not _dragging:
		return

	_dragger.global_position = mouse_pos
	_joint.node_a = _dragger.get_path()
	_joint.node_b = get_parent().get_path()
	_joint.stiffness = spring_stiffness
	_joint.damping = spring_damping
	_joint.length = spring_length


func _stop_drag() -> void:
	_dragging = false
	drag_stopped.emit()

	if _dragger:
		_dragger.queue_free()
		_dragger = null
		_joint = null


func _is_mouse_over(mouse_pos: Vector2) -> bool:
	var space := _dect.get_world_2d().direct_space_state
	var query := PhysicsPointQueryParameters2D.new()
	query.position = mouse_pos
	query.collide_with_areas = true
	query.collide_with_bodies = false
	var results := space.intersect_point(query)
	return results.any(func(r): return r["collider"] == _dect)


func _on_enter() -> void:
	_set_hover(true)


func _on_exit() -> void:
	_set_hover(false)


func _set_hover(value: bool) -> void:
	if value == _hovering:
		return
	_hovering = value
	if value:
		hovered.emit()
	else:
		unhovered.emit()