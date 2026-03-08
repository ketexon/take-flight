class_name TrapPhaseGrid
extends Node

@export var _obstacle_tilemap_layer: TileMapLayer
@export var _grid_size: Vector2i

var astar_grid: AStarGrid2D
var trap_triggers: Dictionary[Vector2i, TrapTrigger] = {}
var door: TrapPhaseDoor


func get_cell_center(cell: Vector2i) -> Vector2:
	return (Vector2(cell) + Vector2.ONE / 2) * astar_grid.cell_size


func get_cell_at_point(point: Vector2) -> Vector2i:
	return Vector2i((point / astar_grid.cell_size).floor())


func _ready() -> void:
	astar_grid = AStarGrid2D.new()
	astar_grid.region = Rect2i(Vector2i.ZERO, _grid_size)
	astar_grid.cell_size = _obstacle_tilemap_layer.tile_set.tile_size
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_ONLY_IF_NO_OBSTACLES;
	astar_grid.update()
	
	_bake()


func _bake() -> void:
	for cell in _obstacle_tilemap_layer.get_used_cells():
		astar_grid.set_point_solid(cell)


func on_character_entered_cell(cell: Vector2i, character: TrapPhaseCharacter) -> void:
	if cell in trap_triggers:
		var trap_trigger := trap_triggers[cell]
		trap_trigger.trigger(character)


func register_trap(trap: TrapTrigger) -> void:
	if trap.cell in trap_triggers:
		push_warning(
			"Trap {0} already registered at coordinate {1}. Not registering."
				.format([trap, trap.cell])
		)
		return
	trap_triggers[trap.cell] = trap


func unregister_trap(trap: TrapTrigger) -> void:
	if trap.cell not in trap_triggers:
		push_warning(
			"Tried to unregister trap {0} at {1} but does not exist."
				.format([trap, trap.cell])
		)
		return
	
	if trap_triggers[trap.cell] != trap:
		push_warning(
			"Tried to unregister trap {0} at {1} but different trap is at cell."
				.format([trap, trap.cell])
		)
		return
	trap_triggers.erase(trap.cell)


func register_door(new_door: TrapPhaseDoor) -> void:
	door = new_door
