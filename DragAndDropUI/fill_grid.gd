extends Node2D

var tile_scene = preload("res://DragAndDropUI/drop_spot.tscn")
var grid_vert_offset = 64 #TODO: should not hard code these values
var grid_hor_offset = 64
var gap = 16


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# a sample grid size; This should and will be changed later
	for row in range(0, 5):
		for col in range(0, 5):
			var tile = tile_scene.instantiate()
			add_child(tile)
			tile.position = Vector2(grid_hor_offset + (128) * row, \
			grid_vert_offset + (128) * col)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
