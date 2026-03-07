extends Node2D

const SPEED = 50.0
var time = 0
var amplitude = randi_range(25,200) # Height of the wave
var frequency = randi_range(1,4)  # Speed of the wave
var target: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var center = get_viewport().get_camera_2d().get_screen_center_position()
	var v_size = get_viewport_rect().size / get_viewport().get_camera_2d().zoom
	var right_edge_x = center.x + (v_size.x / 2.0) + 50
	position.x=right_edge_x

	position.y=(randi() %600 + 50) * -1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	position.x -= SPEED * delta
	position.y += sin(time * frequency) * amplitude * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	print("im duck lol")
	if position.x < 0:
		await get_tree().create_timer(.5).timeout
		queue_free() 


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("You are die")
