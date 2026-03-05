class_name TrapPhaseGrid
extends Node

@export var _obstacle_tilemap_layer: TileMapLayer
@export var _grid_size: Vector2i

var astar_grid: AStarGrid2D

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
