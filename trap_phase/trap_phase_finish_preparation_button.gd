class_name TrapPhaseFinishPreparationButton
extends BaseButton


func _ready() -> void:
	pressed.connect(_on_pressed)


func _on_pressed() -> void:
	TrapPhase.current.enemy_spawner.start_spawning()
