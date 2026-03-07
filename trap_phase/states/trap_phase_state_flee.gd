class_name TrapPhaseStateFlee
extends StateMachineState


func on_entered() -> void:
	Modal.instance.show_modal(
		"Escape!",
		"Were your traps... too good?",
	)
	await Modal.instance.finished
	TrapPhase.current.player.controller.is_enabled = true
	
	TrapPhase.current.player.entered_door.connect(state_machine.transition)


func on_exited() -> void:
	TrapPhase.current.player.entered_door.disconnect(state_machine.transition)
	TrapPhase.current.player.controller.is_enabled = false
	
