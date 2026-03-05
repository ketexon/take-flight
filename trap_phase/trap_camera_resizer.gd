class_name TrapCameraResizer
extends Node

@export var _target_size: Vector2
@export var _phantom_camera: PhantomCamera2D

func _ready() -> void:
	get_viewport().size_changed.connect(_on_viewport_size_changed)
	_on_viewport_size_changed()


func _on_viewport_size_changed() -> void:
	var size := get_viewport().get_visible_rect().size
	var zoom_ratio := size/_target_size
	var target_zoom = min(zoom_ratio.x, zoom_ratio.y)
	
	_phantom_camera.zoom = Vector2.ONE * target_zoom
