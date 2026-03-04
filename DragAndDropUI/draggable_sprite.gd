extends Sprite2D

var is_dragging = false
#var mouse_offset #center mouse on click
var delay = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func _input(event) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if get_rect().has_point(to_local(event.position)):
				print('down')
				is_dragging = true
				#mouse_offset = get_global_mouse_position() - global_position
		else:
			is_dragging = false
			print('up')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if is_dragging:
		var tween = get_tree().create_tween()
#		subtract mouse_offset from global position if you don't want the tile to automatically center
		tween.tween_property(self, "position", get_global_mouse_position(), delay * delta)
