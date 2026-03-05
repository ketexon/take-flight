class_name TrapCameraResizer
extends Node

func _ready() -> void:
	get_viewport().size_changed.connect(_on_viewport_size_changed)
	_on_viewport_size_changed()


func _on_viewport_size_changed() -> void:
	var size := get_viewport().get_visible_rect().size
	print(size)
