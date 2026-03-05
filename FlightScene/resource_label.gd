extends Control
@export var label: Label
var score = 0



func _on_resource_pickup() -> void:
	score += 1
	print(score)
	label.text = "Resources: %s" % score
