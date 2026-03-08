class_name TrapPhaseCharacterMovement
extends Node

@export var _character: TrapPhaseCharacter
@export var _move_duration: float = 0.1

var current_cell := Vector2i.ZERO

var _cur_tween: Tween = null


signal move_finished


func _ready() -> void:
	current_cell = TrapPhase.current.grid.get_cell_at_point(_character.global_position)
	TrapPhase.current.grid.on_character_entered_cell(current_cell, _character)


func move_to_cell(cell: Vector2i) -> void:
	var target_position := TrapPhase.current.grid.get_cell_center(cell)
	if _cur_tween != null:
		_cur_tween.kill()
	_cur_tween = create_tween()
	_cur_tween.set_ease(Tween.EASE_OUT)
	_cur_tween.set_trans(Tween.TRANS_BACK)
	_cur_tween.tween_property(_character, "global_position", target_position, _move_duration)
	
	await _cur_tween.finished
	
	current_cell = cell
	TrapPhase.current.grid.on_character_entered_cell(current_cell, _character)
	
	move_finished.emit()


func try_move_dir(dir: Vector2i) -> bool:
	var target_cell := current_cell + dir
	if not can_move_to_cell(target_cell):
		return false
	move_to_cell(target_cell)
	return true


func can_move_to_cell(cell: Vector2i) -> bool:
	return (
		TrapPhase.current.astar_grid.region.has_point(cell)
		and not TrapPhase.current.astar_grid.is_point_solid(cell)
	)
