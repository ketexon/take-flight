class_name TrapPhaseGridObject
extends Node2D

var cell: Vector2i = Vector2i.ZERO

func _ready() -> void:
	update_cell()
	

func update_cell() -> void:
	cell = TrapPhase.current.grid.get_cell_at_point(global_position)
