extends Control

@export var _size: float = 1920
@export var _speed: float = 200

func _process(delta: float) -> void:
	position.x -= delta * _speed
	position.x = fmod(position.x, _size)
