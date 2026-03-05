class_name TrapPhaseEnemyNavigation
extends Node


@export var _enemy: TrapPhaseEnemy
@export var _move_timer: Timer
@export var _move_duration: float = 0.1


var _current_cell: Vector2i
var _path: PackedVector2Array
var _path_index: int = 0

var _cur_tween: Tween
var _path_offset: Vector2

func _ready() -> void:
	var cell_size := TrapPhase.current.astar_grid.cell_size
	_path_offset = cell_size/2
	var corner_pos := _enemy.position - _path_offset
	_current_cell = Vector2i((corner_pos/cell_size).round())
	_path = TrapPhase.current.astar_grid.get_point_path(
		_current_cell,
		TrapPhase.current.target_cell
	)
	
	_move_timer.timeout.connect(_on_move_timer_timeout)
	
	_move_timer.start()

func _on_move_timer_timeout() -> void:
	if _path_index + 1 >= len(_path):
		return
	_path_index += 1
	var path_position = _path[_path_index]
	if _cur_tween != null:
		_cur_tween.kill()
	_cur_tween = create_tween()
	_cur_tween.set_ease(Tween.EASE_OUT)
	_cur_tween.set_trans(Tween.TRANS_BACK)
	_cur_tween.tween_property(_enemy, "position", path_position + _path_offset, _move_duration)
