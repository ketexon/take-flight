class_name TrapArrow
extends Area2D


@export var _speed: float = 180.0


func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area2D) -> void:
	if area is not TrapPhaseCharacter:
		return
	
	var character := area as TrapPhaseCharacter
	if character.dead:
		return
	
	character.kill()
	queue_free()


func _physics_process(delta: float) -> void:
	position += Vector2.UP * delta * _speed
