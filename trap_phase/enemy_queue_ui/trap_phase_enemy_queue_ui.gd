class_name TrapPhaseEnemyQueueUI
extends Node

@export var _queue_icon_container: Control
@export var _queue_icon_packed_scene: PackedScene

func _ready() -> void:
	var enemy_queue := TrapPhase.current.enemy_spawner.enemy_queue
	for enemy_data in enemy_queue:
		var queue_icon: TrapPhaseEnemyQueueUIIcon = _queue_icon_packed_scene.instantiate()
		queue_icon.bind_enemy(enemy_data)
		_queue_icon_container.add_child(queue_icon)
	
	TrapPhase.current.enemy_spawner.enemy_spawned.connect(_on_enemy_spawned)


func _on_enemy_spawned(_enemy: TrapPhaseEnemy) -> void:
	var icon = _queue_icon_container.get_child(0)
	_queue_icon_container.remove_child(icon)
	icon.queue_free()
