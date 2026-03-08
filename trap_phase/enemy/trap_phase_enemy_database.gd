class_name TrapPhaseEnemyDatabase
extends Resource

@export var enemies: Array[TrapPhaseEnemyData]

func pick_random() -> TrapPhaseEnemyData:
	return enemies.pick_random()
