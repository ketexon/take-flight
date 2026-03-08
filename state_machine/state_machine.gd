class_name StateMachine
extends Node


@export var _start_first_child: bool = true
@export var _start_state: StateMachineState


var active_state: StateMachineState = null


func _ready() -> void:
	if _start_state == null and _start_first_child and get_child_count() > 0:
		_start_state = get_child(0)
	if _start_state != null:
		enter(_start_state)


func enter(state: StateMachineState) -> void:
	state.state_machine = self
	
	active_state = state
	active_state.on_entered()


func exit() -> void:
	active_state.on_exited()
	active_state = null


func transition(state: StateMachineState = null) -> void:
	if state == null:
		state = active_state.default_transition_state
	
	if state == null and active_state.default_transition_to_next_child:
		var next_index := active_state.get_index() + 1
		var parent := active_state.get_parent()
		if next_index < parent.get_child_count():
			state = parent.get_child(next_index)
	
	exit()
	
	if state != null:
		enter(state)
