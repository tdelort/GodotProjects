extends RigidBody2D

signal ended(bullet_position, bullet_color)

const MIN_LIFE_SPAN = 0.2
const MAX_LIFE_SPAN = 0.5

export var min_speed = 300
export var max_speed = 600

var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	$LifeSpanTimer.wait_time = random_lifespan()
	$LifeSpanTimer.start()

func random_lifespan():
	return 2 * abs(rng.randfn()) * rand_range(MIN_LIFE_SPAN,MAX_LIFE_SPAN)

func _on_LifeSpanTimer_timeout():
	emit_signal("ended",Vector2(position + get_parent().position),Color.red)
	queue_free()
