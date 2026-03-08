class_name TrapPhaseStateFlee
extends StateMachineState


@export var _transition_scene: PackedScene


var _preloaded_transition_scene: Node


func on_entered() -> void:
	Modal.instance.show_modal(
		"Escape!",
		"Were your traps... too good?",
	)
	await Modal.instance.finished
	TrapPhase.current.player.controller.is_enabled = true
	
	TrapPhase.current.player.entered_door.connect(_on_player_entered_door)
	
	_preloaded_transition_scene = _transition_scene.instantiate()


func _on_player_entered_door() -> void:
	SceneTransition.instance.transition_out()
	await SceneTransition.instance.transition_finished
	get_tree().change_scene_to_node(_preloaded_transition_scene)


func on_exited() -> void:
	TrapPhase.current.player.entered_door.disconnect(state_machine.transition)
	TrapPhase.current.player.controller.is_enabled = false
	
	if _preloaded_transition_scene != null:
		_preloaded_transition_scene.queue_free()
	
	
