extends Control
class_name SellTrap

@export var trap_frame: TextureRect
@export var trap_type: PackedScene
@export var cost: int
var tree_root: Node

signal trap_purchased

func _ready():
	tree_root = get_tree().root

func _input(event) -> void: #this consumes the event, which may be a problem
	#Detects if mouse is hovering and clicks
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			#TODO: on click, add logic to check the amount of resources a player has
			#if (player.money >= cost):
			var sell_trap_instance = trap_type.instantiate()
			tree_root.add_child(sell_trap_instance)
			sell_trap_instance.cost = cost
			var viewport_center = get_viewport_rect().size / 2
			sell_trap_instance.position = viewport_center
			emit_signal("trap_purchased", [cost])
		


func _on_trap_image_mouse_entered() -> void:
	trap_frame.scale = Vector2(1.2, 1.2)


func _on_trap_image_mouse_exited() -> void:
	trap_frame.scale = Vector2(1, 1)
