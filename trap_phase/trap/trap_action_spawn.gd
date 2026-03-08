class_name TrapActionSpawn
extends TrapAction


@export var _spawned_object: PackedScene


func activate(_character: TrapPhaseCharacter) -> void:
	var instance := _spawned_object.instantiate()
	add_child(instance)
