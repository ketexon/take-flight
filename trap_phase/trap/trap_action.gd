class_name TrapAction
extends Node2D

func _ready():
	if not is_node_ready():
		await ready
	var cell:Vector2i = TrapPhase.current.grid.get_cell_at_point(global_position) 
	self.position = TrapPhase.current.grid.get_cell_center(cell)

@warning_ignore("unused_parameter")
func activate(character: TrapPhaseCharacter):
	pass
