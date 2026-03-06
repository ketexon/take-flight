class_name TrapPhaseStatePrepration
extends StateMachineState

@export var _finish_button: BaseButton

func on_entered() -> void:
	_finish_button.pressed.connect(_on_finish_button_pressed)
	

func on_exited() -> void:
	_finish_button.pressed.disconnect(_on_finish_button_pressed)


func _on_finish_button_pressed() -> void:
	TrapPhase.current.enemy_spawner.start_spawning()
	state_machine.transition()
