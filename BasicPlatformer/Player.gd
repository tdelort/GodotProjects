extends KinematicBody2D

const WALK_SPEED_INC = 50
const WALK_SPEED_DAMP = 20
const WALK_MAX_SPEED = 500
const LIGHT_DASH_SPEED = 600
const HEAVY_DASH_SPEED = 400
const JUMP_SPEED = 1050
const DOUBLE_JUMP_SPEED = 1050
const JUMP_MAX_AIRBORNE_TIME = 0.2
const GRAVITY = 3000

var light_dash_mode = 0
var heavy_dash_mode = 0
var velocity = Vector2()
var nbJumps = 0
var facing = 0 # -1 = left 1 = right
var consecutive_dash = 0

func _ready():
	pass

func _physics_process(delta):
	#managing Inputs :
	if light_dash_mode:
		velocity.y = 0
		
		if $LightAttackTimer.is_stopped():
			light_dash_mode = 0
		else:
# warning-ignore:return_value_discarded
			move_and_slide(Vector2(facing * LIGHT_DASH_SPEED,0), Vector2.UP,true)
		
	elif heavy_dash_mode:
		velocity.y = 0
		
		if $HeavyAttackTimer.is_stopped():
			heavy_dash_mode = 0
		else:
# warning-ignore:return_value_discarded
			move_and_slide(Vector2(facing * HEAVY_DASH_SPEED,0), Vector2.UP,true)
		
	else: 
		if Input.is_action_just_pressed("action_x") and $LightAttackTimer.time_left == 0:
			if consecutive_dash < 3:
				light_dash_mode = 1
				$LightAttackTimer.start()
			consecutive_dash += 1
		
		if Input.is_action_just_pressed("action_y") and $HeavyAttackTimer.time_left == 0:
			if consecutive_dash < 3:
				heavy_dash_mode = 1
				$HeavyAttackTimer.start()
			consecutive_dash += 1
		
		var walk = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		if walk != 0:
			facing = sign(walk)
		
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
			consecutive_dash = 0
		
		# Y velocity (intergrates force into velocity)
		velocity.y += GRAVITY * delta
		
		# X velocity
		if walk == 0:
			velocity.x -= WALK_SPEED_DAMP * sign(velocity.x)
		velocity.x += walk * WALK_SPEED_INC
		velocity.x = clamp(velocity.x,-WALK_MAX_SPEED,WALK_MAX_SPEED)
		
		# Integrate velocity into motion and move.
		velocity = move_and_slide(velocity, Vector2.UP,true)
