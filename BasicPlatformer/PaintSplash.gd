extends Node2D

var texture_array = [ preload("res://Assets/Paint01.png")
, preload("res://Assets/Paint02.png")
, preload("res://Assets/Paint03.png") ]

func _ready():
	get_child(0).texture = texture_array[randi() % texture_array.size()]
	pass # Replace with function body.


func set_position(coord):
	position = coord

func set_scale(val):
	scale = Vector2(val, val)
