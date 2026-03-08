extends Node2D

const SPEED = 300.0
signal pickup

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	var center = get_viewport().get_camera_2d().get_screen_center_position()
	var v_size = get_viewport_rect().size / get_viewport().get_camera_2d().zoom
	var right_edge_x = center.x + (v_size.x / 2.0) + 50
	position.x=right_edge_x

	position.y=(randi() %600 + 50) * -1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -= SPEED * delta
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	print("im dead lol")
	if position.x < 0:
		await get_tree().create_timer(.5).timeout
		queue_free() 

#When player enters area, emit pickup signal to resource label
#then delete the resource
func _on_area_2d_body_entered(_body: Node2D) -> void:
	pickup.emit()
	queue_free()
