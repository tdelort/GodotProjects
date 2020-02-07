extends Sprite

signal draw_splash()

const MIN_LIFE_SPAN = 0.5
const MAX_LIFE_SPAN = 1
const MIN_RADIUS = 20
const MAX_RADIUS = 80

# Called when the node enters the scene tree for the first time.
func _ready():
	$LifeSpanTimer.wait_time = rand_range(MIN_LIFE_SPAN,MAX_LIFE_SPAN)
	$LifeSpanTimer.start()



func _on_LifeSpanTimer_timeout():
	var radius = randi() % (MAX_RADIUS + MIN_RADIUS) + MIN_RADIUS
	
	queue_free()
