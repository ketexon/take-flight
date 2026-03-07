class_name TrapPhaseStateWave
extends StateMachineState

func on_entered() -> void:
	Modal.instance.show_modal(
		"Hide!",
		"Praydge they don't get you Dx",
	)
	await Modal.instance.finished
	TrapPhase.current.enemy_spawner.start_spawning()
	TrapPhase.current.enemy_spawner.all_enemies_killed.connect(_on_all_enemies_killed)


func on_exited() -> void:
	TrapPhase.current.enemy_spawner.all_enemies_killed.disconnect(_on_all_enemies_killed)
	

func _on_all_enemies_killed() -> void:
	state_machine.transition()
