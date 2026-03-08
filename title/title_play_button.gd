extends BaseButton


@export_file("*.tscn") var _scene_path: String


func _ready() -> void:
	SceneTransition.instance.transition_in()
	
	pressed.connect(_on_pressed)
	SceneTransition.instance.set_center_percent(Vector2.ONE / 2)
	SceneTransition.instance.transition_in()


func _on_pressed() -> void:
	disabled = true
	SceneTransition.instance.transition_out()
	await SceneTransition.instance.transition_finished
	get_tree().change_scene_to_file(_scene_path)
	
