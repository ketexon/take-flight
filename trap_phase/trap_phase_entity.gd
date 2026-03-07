class_name TrapPhaseCharacter
extends Area2D


@export var movement: TrapPhaseCharacterMovement


signal killed


var dead := false


func kill() -> void:
	dead = true
	on_killed()
	killed.emit()


func on_killed() -> void:
	pass
