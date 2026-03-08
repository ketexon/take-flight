extends Control


##A reference to the child texture rect. Displays for the user to move around
@export var texture_rect :TextureRect
##The image icon for this representation
@export var texture :Texture
##The trap which will be spawned once the state_controller's scene transitions
##to spawning enemies
@export var trap_to_spawn : PackedScene
##The scene which will be spawned and linked to the trap_to_spawn 
@export var disjoint_trigger_to_spawn :PackedScene
##This will be refunded to the player if the icon is deleted
@export var cost:int #filled when trap is spawned by UI
var is_dragging = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture_rect.texture = texture


func _process(_delta: float) -> void:
	if is_dragging:
		global_position = get_global_mouse_position() - texture_rect.size / 2
		

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
		self.queue_free.call_deferred()
