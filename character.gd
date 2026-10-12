extends CharacterBody2D

@onready var collision = $CollisionShape2D
@onready var sprite = $Sprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Handles crouch
	if Input.is_action_just_pressed("Crouch"):
		collision.scale.y = 0.5
		sprite.scale.y = 0.5
	if Input.is_action_just_released("Crouch"):
		collision.scale.y = 1
		sprite.scale.y = 1


	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
