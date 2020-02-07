extends KinematicBody2D

const WALK_SPEED_INC = 50
const WALK_SPEED_DAMP = 20
const WALK_MAX_SPEED = 500
const DASH_SPEED = 600
const JUMP_SPEED = 1050
const DOUBLE_JUMP_SPEED = 1050
const JUMP_MAX_AIRBORNE_TIME = 0.2
const GRAVITY = 3000

var DASH_MODE = 0
var velocity = Vector2()
var nbJumps = 0
enum facing { RIGHT, LEFT } 

func _ready():
	pass

func _physics_process(delta):
	#managing Inputs :
	if DASH_MODE:
		if $AttackTimer.is_stopped():
			DASH_MODE = 0
		else:
			move_and_slide(Vector2(DASH_SPEED,0), Vector2.UP,true)
	else:
		if Input.is_action_pressed("action_x") and $AttackTimer.time_left == 0:
			$AttackTimer.start()
			DASH_MODE = 1;
		
		var walk = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		
		if Input.is_action_just_pressed("jump"):
			if nbJumps == 0: #can jump not on floor
				velocity.y = -JUMP_SPEED
				nbJumps = 1
				$DoubleJumpTimer.start()
			elif $DoubleJumpTimer.is_stopped() and nbJumps == 1:
					velocity.y = -DOUBLE_JUMP_SPEED
					nbJumps = 2
		
		if is_on_floor():
			$DoubleJumpTimer.stop()
			nbJumps = 0
	
		# Y velocity (intergrates force into )
		velocity.y += GRAVITY * delta
		
		# X velocity
		if walk == 0:
			velocity.x -= WALK_SPEED_DAMP * sign(velocity.x)
		velocity.x += walk * WALK_SPEED_INC
		velocity.x = clamp(velocity.x,-WALK_MAX_SPEED,WALK_MAX_SPEED)
		
	
	
		# Integrate velocity into motion and move.
		velocity = move_and_slide(velocity, Vector2.UP,true)
