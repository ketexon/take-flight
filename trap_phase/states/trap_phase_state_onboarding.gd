class_name TrapPhaseStateOnboarding
extends StateMachineState

@export var _onboarding: Onboarding


static var _showed := false


func on_entered() -> void:
	if !_showed:
		await _onboarding.start()
		_showed = true
	state_machine.transition()
