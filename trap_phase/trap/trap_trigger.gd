class_name TrapTrigger
extends Node2D


@export var action: TrapAction
@export var _once: bool = false


var cell := Vector2i.ZERO
var _already_triggered := false

func _enter_tree() -> void:
	if not is_node_ready():
		await ready
	cell = TrapPhase.current.grid.get_cell_at_point(global_position) 
	##NOTE: this looks visually correct, but I am not sure if this will mess with the hitboxes
	self.position = TrapPhase.current.grid.get_cell_center(cell)
	TrapPhase.current.grid.register_trap(self)


func _exit_tree() -> void:
	TrapPhase.current.grid.unregister_trap(self)


func trigger(character: TrapPhaseCharacter) -> void:
	if _once and _already_triggered:
		return
	_already_triggered = true
	
	if action == null:
		push_warning("Trap trigger {0} has no action".format([self]))
		return
	action.activate(character)
