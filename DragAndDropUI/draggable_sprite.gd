extends Sprite2D

var is_dragging = false
#var mouse_offset #center mouse on click
var delay = 2
var drop_spots = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#NOTE: _ready functions are *ALWAYS* called in from deepest child node to 
	#and proceding toward the parent. Thus we defer the call to ensure
	#ALL _ready funcs have been called and thus the drop_slots are instanced
	call_deferred("_populate_drop_spots")
	
func _populate_drop_spots() -> void:
	drop_spots = get_tree().get_nodes_in_group("drop_spot_group")
	
func _input(event) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if get_rect().has_point(to_local(event.position)):
				print('down')
				is_dragging = true
				#mouse_offset = get_global_mouse_position() - global_position
		else:
			is_dragging = false
			for drop_spot in drop_spots:
				if drop_spot.has_overlapping_areas() && \
				 drop_spot.get_overlapping_areas().has(self.get_node("Area2D")):
					#TODO: if overlapping with multiple drop_spots, this will 
					var snap_position = drop_spot.position
					var tween = get_tree().create_tween()
					tween.tween_property(self,"position", snap_position, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if is_dragging:
		var tween = get_tree().create_tween()
#		subtract mouse_offset from global position if you don't want the tile to automatically center
		tween.tween_property(self, "position", get_global_mouse_position(), delay * delta)
