class_name TrapPhaseStatePrepration
extends StateMachineState


@export var _finish_button: BaseButton
@export var _shop_interface: ShopUI

func on_entered() -> void:
	Modal.instance.show_modal(
		"Prepare!",
		"Set up traps to fend off the attackers",
	)
	
	await Modal.instance.finished
	_finish_button.pressed.connect(_on_finish_button_pressed)
	
	

func on_exited() -> void:
	_finish_button.pressed.disconnect(_on_finish_button_pressed)


func _on_finish_button_pressed() -> void:
	state_machine.transition()
