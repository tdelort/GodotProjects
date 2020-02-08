extends Node2D

export (PackedScene) var PaintBullet

func _ready():
	fire()

func fire():
	for _i in range(0,5):
		var boulette = PaintBullet.instance()
		add_child(boulette)
		var direction = 0
		boulette.position = Vector2(0,0)
		direction += rand_range(-PI/8, PI/8)
		boulette.rotation = direction
		boulette.linear_velocity = Vector2(rand_range(boulette.min_speed,boulette.max_speed),0)
		boulette.linear_velocity = boulette.linear_velocity.rotated(direction)
		boulette.connect("ended",self.get_parent(),"_on_PaintBullet_ended")
