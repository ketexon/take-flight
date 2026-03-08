class_name TrapPhasePlayerController
extends Node


@export var _move_delay := 0.1
@export var _movement: TrapPhaseCharacterMovement


var is_enabled: bool = false:
	set(v):
		if is_enabled == v:
			return
		is_enabled = v
		enabled.emit()

signal enabled
signal entered_door

var _movement_stack: Array[Vector2i] = []
const _MOVE_ACTION_DIR_MAP: Dictionary[StringName, Vector2i] = {
	&"move_left": Vector2i(-1, 0),
	&"move_right": Vector2i(1, 0),
	&"move_up": Vector2i(0, -1),
	&"move_down": Vector2i(0, 1),
}


func _ready() -> void:
	_move_coroutine()


func _unhandled_input(event: InputEvent) -> void:
	if not is_enabled:
		return
	
	var handled := false 
	
	for action in _MOVE_ACTION_DIR_MAP:
		if not event.is_action(action):
			continue
		var dir := _MOVE_ACTION_DIR_MAP[action]
		if event.is_pressed() and dir not in _movement_stack:
			_movement_stack.push_back(dir)
			handled = true
		elif event.is_released():
			_movement_stack.erase(dir)
			handled = true
	
	if handled:
		get_viewport().set_input_as_handled()


func _try_enter_door() -> bool:
	var door := TrapPhase.current.grid.door
	if _movement.current_cell != door.cell:
		return false
	if _movement_stack.back() != door.exit_dir:
		return false
	
	_enter_door()
	
	return true
	

func _enter_door() -> void:
	is_enabled = false
	
	var door := TrapPhase.current.grid.door
	_movement.move_to_cell(
		door.cell + door.exit_dir
	)
	
	await _movement.move_finished
	
	entered_door.emit()


func _move_coroutine() -> void:
	while true:
		if not is_enabled:
			await enabled
			continue
		
		if not _movement_stack.is_empty():
			if _try_enter_door():
				continue
			if _movement.try_move_dir(_movement_stack.back()):
				await _movement.move_finished
				await get_tree().create_timer(_move_delay).timeout
				continue
		await get_tree().process_frame
