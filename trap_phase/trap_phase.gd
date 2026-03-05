class_name TrapPhase
extends Node

static var current: TrapPhase = null


@export var grid: TrapPhaseGrid
@export var target_cell: Vector2i
@export var enemy_spawner: TrapPhaseEnemySpawner


var astar_grid: AStarGrid2D:
	get:
		return grid.astar_grid

func _enter_tree() -> void:
	current = self


func _exit_tree() -> void:
	if current == self:
		current = null
