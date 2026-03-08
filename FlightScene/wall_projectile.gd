extends Node2D

const SPEED = 50.0
var target: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var center = get_viewport().get_camera_2d().get_screen_center_position()
	var v_size = get_viewport_rect().size / get_viewport().get_camera_2d().zoom
	var right_edge_x = center.x + (v_size.x / 2.0) + 50
	position.x=right_edge_x
	if(randi()%2==1):
		position.y= center.y + ((v_size.y / 2.0))  - 125
	else:
		position.y= center.y - ((v_size.y / 2.0) ) + 125

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -= SPEED * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	print("im wall lol")
	if position.x < 0:
		await get_tree().create_timer(.5).timeout
		queue_free() 


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("You are die")
