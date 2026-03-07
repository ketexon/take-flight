class_name TrapActionSpawn
extends TrapAction


@export var _spawner: TrapSpawner


func activate(_character: TrapPhaseCharacter):
	_spawner.spawn()
