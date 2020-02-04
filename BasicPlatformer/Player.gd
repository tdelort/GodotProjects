extends KinematicBody2D

const GRAVITY = 500

var force = Vector2()
var velocity = Vector2()

func _ready():
	pass # Replace with function body.

func touch_surface(): 
	return (is_on_wall() or is_on_floor())

func _process(_delta):
	pass

func _physics_process(delta):
	#code mvt physics
	pass
	
	
