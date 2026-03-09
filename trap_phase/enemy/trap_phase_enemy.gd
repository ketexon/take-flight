class_name TrapPhaseEnemy
extends TrapPhaseCharacter


@export var navigation: TrapPhaseEnemyNavigation


func on_killed() -> void:
	TrapPhase.current.enemy_spawner.on_enemy_killed()
	if is_instance_valid(navigation):
		navigation.queue_free()
