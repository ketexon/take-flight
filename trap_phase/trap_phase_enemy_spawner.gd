class_name TrapPhaseEnemySpawner
extends Node

@export var _enemy_count: int = 5
@export var _enemy_database: TrapPhaseEnemyDatabase
@export var _enemy_spawn_location: Node2D
@export var _enemy_container: Node
@export var _spawn_timer: Timer

var enemy_queue: Array[TrapPhaseEnemyData] = []

signal enemy_spawned(enemy: TrapPhaseEnemy)


func _ready() -> void:
	_generate_enemy_queue()


func _generate_enemy_queue() -> void:
	for i in _enemy_count:
		enemy_queue.push_back(_enemy_database.pick_random())


func start_spawning() -> void:
	_spawn_timer.timeout.connect(_spawn_enemy)
	_spawn_enemy()
	_spawn_timer.start()


func _spawn_enemy() -> void:
	if enemy_queue.is_empty():
		push_warning("Called _spawn_enemy when enemy_queue is empty")
		return
	var enemy_data: TrapPhaseEnemyData = enemy_queue.pop_front()
	var enemy: TrapPhaseEnemy = enemy_data.packed_scene.instantiate()
	enemy.global_position = _enemy_spawn_location.global_position
	_enemy_container.add_child(enemy)
	
	enemy_spawned.emit(enemy)
	
	if enemy_queue.is_empty():
		_spawn_timer.timeout.disconnect(_spawn_enemy)
		_spawn_timer.stop()
