class_name TrapPhaseEnemyQueueUIIcon
extends Node


@export var _texture_rect: TextureRect


func bind_enemy(enemy_data: TrapPhaseEnemyData) -> void:
	if enemy_data.queue_icon_texture != null:
		_texture_rect.texture = enemy_data.queue_icon_texture
