class_name TrapPhaseCharacter
extends Area2D


@export var movement: TrapPhaseCharacterMovement


signal killed


var dead := false

var _death_velocity := Vector2(500, -500)
const _death_velocity_min := Vector2(400, -300)
const _death_velocity_max := Vector2(800, -800)
const _death_gravity := 300.0
var _death_rot_velocity := 2

func kill() -> void:
	dead = true
	on_killed()
	killed.emit()
	
	_calculate_death_velocity()
	
	
func _calculate_death_velocity() -> void:
	_death_velocity = lerp(
		_death_velocity_min,
		_death_velocity_max,
		randf()
	)
	if randf() > 0.5:
		_death_velocity.x *= -1
	if randf() > 0.5:
		_death_rot_velocity *= -1


func on_killed() -> void:
	pass


func _process(delta: float) -> void:
	if not dead:
		return
	
	position += _death_velocity * delta
	_death_velocity.y += gravity * delta
	rotation += _death_rot_velocity * delta
