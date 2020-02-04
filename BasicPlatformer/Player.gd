extends KinematicBody2D

const WALK_SPEED_INC = 50
const WALK_SPEED_DAMP = 20
const WALK_MAX_SPEED = 500
const JUMP_SPEED = 1050
const DOUBLE_JUMP_SPEED = 1050
const JUMP_MAX_AIRBORNE_TIME = 0.2
const GRAVITY = 3000

var velocity = Vector2()
var nbJumps = 0
enum facing { RIGHT, LEFT } 

func _ready():
	$Tween.interpolate_property(self, "position:x",
			0, 64, 1,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)

func _physics_process(delta):
	var force_y = GRAVITY
	#left right movement
	var walk = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var jump = Input.is_action_pressed("jump")
	
	#managing attacks
	if Input.is_action_pressed("action_x") and $AttackTimer.time_left == 0:
		$AttackTimer.start()
		$Tween.start()
	
	#damping for left/right movement
	if walk == 0:
		velocity.x -= WALK_SPEED_DAMP * sign(velocity.x)
	velocity.x += walk * WALK_SPEED_INC
	velocity.x = clamp(velocity.x,-WALK_MAX_SPEED,WALK_MAX_SPEED)
	
	if is_on_floor():
		$DoubleJumpTimer.stop()
		nbJumps = 0
	
	if jump:
		if nbJumps == 0: #can jump not on floor
			velocity.y = -JUMP_SPEED
			nbJumps = 1
			$DoubleJumpTimer.start()
		elif $DoubleJumpTimer.is_stopped() and nbJumps == 1:
				velocity.y = -DOUBLE_JUMP_SPEED
				nbJumps = 2
	
	# Integrate forces to velocity.
	velocity.y += force_y * delta
	# Integrate velocity into motion and move.
	velocity = move_and_slide(velocity, Vector2.UP,true)
	
	
