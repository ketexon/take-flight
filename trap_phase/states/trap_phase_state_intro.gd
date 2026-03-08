class_name TrapPhaseStateIntro
extends StateMachineState


@export var _delay := 1.0


func on_entered() -> void:
	await get_tree().create_timer(_delay).timeout
	SceneTransition.instance.transition_in()
	await SceneTransition.instance.transition_finished
	state_machine.transition()
