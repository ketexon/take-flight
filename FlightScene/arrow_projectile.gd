extends Node2D

const speed = 200.0
var time = 0
var direction: Vector2 = Vector2.LEFT
var target: Vector2
var player: CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var center = get_viewport().get_camera_2d().get_screen_center_position()
	var v_size = get_viewport_rect().size / get_viewport().get_camera_2d().zoom
	var right_edge_x = center.x + (v_size.x / 2.0) + 50
	position.x=right_edge_x

	position.y=(randi() %600 + 50) * -1
	
	direction = (target - global_position).normalized()
	global_rotation = direction.angle() + PI / 2.0
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	translate(direction*speed*delta)


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	print("im arrow lol")
	await get_tree().create_timer(.5).timeout
	queue_free() 


func _on_area_2d_body_entered(_body: Node2D) -> void:
	player.die()
