class_name TrapPhasePlayer
extends TrapPhaseCharacter


@export var controller: TrapPhasePlayerController


signal entered_door


func _ready() -> void:
	controller.entered_door.connect(entered_door.emit)


func on_killed() -> void:
	controller.is_enabled = false
