extends RigidBody2D

@export var custom_friction: float = 200

func _ready():
	# Disable default gravity scale
	gravity_scale = 0

func _physics_process(delta):
	# Apply friction
	apply_friction(delta)

func apply_friction(delta):
	if linear_velocity.length() > 0:
		var friction_force = linear_velocity.normalized() * custom_friction * delta
		if friction_force.length() > linear_velocity.length():
			linear_velocity = Vector2(0, 0) # Fully stop the movement
			angular_velocity = 0 # Stop the rotation too
		else:
			linear_velocity -= friction_force
