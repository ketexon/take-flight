extends Control
class_name SellTrapUI

@export var trap_frame: TextureRect
@export var cost: int

##A reference to the draggable icon which will eventually spawn the trap indicated by trap_scene
@export var representation: PackedScene
##A reference to the scene which will eventually spawn the trap
@export var trap_type: PackedScene
##Determines whether this will have to also spawn a pressure plate
@export var is_disjoint: bool = false
##A reference to the pressure plate which will be used to trigger the trap.
##If is_disjoint is false, this is ignored.
@export var disjoint_trigger_object: PackedScene


var tree_root: Node
var is_hovered:bool

signal trap_purchased

func _ready():
	is_hovered = false
	self.get_child(0).get_child(0).text = "%d" % [cost]
	tree_root = get_tree().root

func _input(event) -> void: 
	#Detects if mouse is hovering and clicks
	if(not is_hovered): return
	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			#TODO: on click, add logic to check the amount of resources a player has
			#if (player.money >= cost):
			var sell_trap_instance = representation.instantiate()
			representation.trap_to_spawn = trap_type
			tree_root.add_child(sell_trap_instance)
			#sell_trap_instance.cost = cost
			var viewport_center = get_viewport_rect().size / 2
			sell_trap_instance.position = viewport_center
			emit_signal("trap_purchased", [cost])
			print("%s spawned trap of reference %s" % [self, sell_trap_instance])

func _process(_delta: float):
	if (is_hovered):
		trap_frame.scale = Vector2(1.5, 1.5)
	else:
		trap_frame.scale = Vector2(1.2, 1.2)		


func _on_trap_image_mouse_entered() -> void:
	is_hovered = true


func _on_trap_image_mouse_exited() -> void:
	is_hovered = false
