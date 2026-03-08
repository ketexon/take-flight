class_name TrapTrigger
extends Node2D


@export var action: TrapAction
@export var _once: bool = false


var cell := Vector2i.ZERO
var _already_triggered := false

func _enter_tree() -> void:
	if not is_node_ready():
		await ready
	print("%v" % self.position)
	cell = TrapPhase.current.grid.get_cell_at_point(global_position)
	self.position = cell
	print("%v" % self.position)
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
