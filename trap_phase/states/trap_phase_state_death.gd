class_name TrapPhaseStateDeath
extends StateMachineState


@export var _state_machine: StateMachine
@export var _pcam: PhantomCamera2D
@export var _you_died: TrapPhaseYouDied


func _ready() -> void:
	TrapPhase.current.player.killed.connect(_on_player_killed)


func on_entered() -> void:
	_pcam.visible = true
	_you_died.fade_in()


func _on_player_killed() -> void:
	_state_machine.transition(self)
