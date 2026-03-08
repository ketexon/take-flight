class_name TrapPhaseStateIntro
extends StateMachineState


@export var _delay := 1.0


func on_entered() -> void:
	await get_tree().create_timer(_delay).timeout
	state_machine.transition()
