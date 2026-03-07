extends Control
class_name SellTrap

@export var trap_frame: TextureRect
@export var trap_type: PackedScene
@export var cost: int
var hovering: bool
var tree_root: Node

func _ready():
	tree_root = get_tree().root

#Detects if mouse is over card sprite
func is_mouse_over_card() -> bool:
	var mouse_pos: Vector2 = get_global_mouse_position()
	var sprite_rect = Rect2(trap_frame.global_position, trap_frame.texture.get_size())
	return sprite_rect.has_point(mouse_pos)

func _input(event) -> void:
	#Detects if mouse is hovering and clicks
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and hovering:
			#TODO: on click, add logic to check the amount of resources a player has
			#if (player.money >= cost):
			var sell_trap_instance = trap_type.instantiate()
			tree_root.add_child(sell_trap_instance)
			var viewport_center = get_viewport_rect().size / 2
			sell_trap_instance.position = viewport_center
		


func _on_trap_image_mouse_entered() -> void:
	trap_frame.scale = Vector2(1.2, 1.2)
	


func _on_trap_image_mouse_exited() -> void:
	trap_frame.scale = Vector2(1, 1)
