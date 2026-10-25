extends CharacterBody2D

@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var character = %Character

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const DASH_VELOCITY = 1000

const MAX_JUMPS = 2
var jumpsLeft := MAX_JUMPS

const MAX_DASHES = 2
var dashesLeft := MAX_DASHES

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump/double jump.
	if is_on_floor():
		jumpsLeft = MAX_JUMPS
	if Input.is_action_just_pressed("Jump") and jumpsLeft > 0:
		velocity.y = JUMP_VELOCITY
		jumpsLeft -= 1

# Handles dashes
	if Input.is_action_just_pressed("Dash") and dashesLeft > 0:
		velocity.x = DASH_VELOCITY
		dashesLeft -= 1
		print(dashesLeft)

	# Handles crouch
	if Input.is_action_just_pressed("Crouch"):
		character.scale.y = 0.5
		character.position.y += 32
	if Input.is_action_just_released("Crouch"):
		character.scale.y = 1
		character.position.y -= 32

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
