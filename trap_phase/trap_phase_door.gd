class_name TrapPhaseDoor
extends TrapPhaseGridObject


@export var exit_dir: Vector2i


func _ready() -> void:
	super()
	TrapPhase.current.grid.register_door(self)
