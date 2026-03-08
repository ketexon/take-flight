extends Control


@export var texture_rect :TextureRect
@export var texture :Texture
@export var cost :int
@export var _finish_button :BaseButton

var is_dragging :bool

const TILE_SIZE = Vector2(64,64)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	is_dragging = false
	texture_rect.texture = texture


func _process(_delta: float) -> void:
	if is_dragging:
		global_position = get_global_mouse_position() - texture_rect.size / 2
		global_position = global_position.snapped(TILE_SIZE)
		
		
func _spawn_trap():
	pass

func _on_texture_rect_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			print('down')
			is_dragging = true
		else:
			is_dragging = false
	
	if (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT):
		emit_signal("trap_sold", [cost])
		print("Refunded %d gold" %cost)
		self.get_parent().queue_free.call_deferred()
