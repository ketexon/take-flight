class_name StateMachineState
extends Node

@export var default_transition_state: StateMachineState
@export var default_transition_to_next_child: bool = true


## The state machine that this state is currently active on
## null if no state machine entered this state
var state_machine: StateMachine


func on_entered() -> void:
	pass


func on_exited() -> void:
	pass
