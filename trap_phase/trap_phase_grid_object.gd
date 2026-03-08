class_name TrapPhaseGridObject
extends Node2D

@export var _start_cell: Vector2i = Vector2i(-1, -1)

var cell: Vector2i = Vector2i.ZERO

func _ready() -> void:
	if _start_cell.x > 0 and _start_cell.y > 0:
		cell = _start_cell
		position = TrapPhase.current.grid.get_cell_center(cell)
	else:
		update_cell()
	

func update_cell() -> void:
	cell = TrapPhase.current.grid.get_cell_at_point(global_position)
