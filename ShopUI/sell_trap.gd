extends Control
class_name SellTrap

@export var trap_frame: TextureRect
@export var trap_type: PackedScene
var hovering: bool

func _process(_delta):
	if is_mouse_over_card():
		hovering = true
		trap_frame.scale = Vector2(1.2, 1.2)
	else:
		hovering = false
		trap_frame.scale = Vector2(1, 1)

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
			#if enough, spawn the trap and allow them to drag
			#else do nothing
			self.queue_free.call_deferred()
		
