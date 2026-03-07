class_name TrapPhaseEnemyNavigation
extends Node


@export var _move_timer: Timer
@export var _movement: TrapPhaseCharacterMovement


var _path: PackedVector2Array
var _path_index: int = 0


func _ready() -> void:
	_path = TrapPhase.current.astar_grid.get_id_path(
		_movement.current_cell,
		TrapPhase.current.player.movement.current_cell
	)
	
	_move_timer.timeout.connect(_on_move_timer_timeout)
	_move_timer.start()


func _on_move_timer_timeout() -> void:
	if _path_index + 1 >= len(_path):
		return
	_path_index += 1
	
	_movement.move_to_cell(_path[_path_index])
