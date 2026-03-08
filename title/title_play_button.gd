extends BaseButton


@export var _scene: PackedScene


func _ready() -> void:
	pressed.connect(_on_pressed)
	SceneTransition.instance.set_center_percent(Vector2.ONE / 2)
	SceneTransition.instance.transition_in()


func _on_pressed() -> void:
	
	SceneTransition.instance.transition_out()
	await SceneTransition.instance.transition_finished
	get_tree().change_scene_to_packed(_scene)
