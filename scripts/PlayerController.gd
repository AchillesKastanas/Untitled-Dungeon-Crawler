extends CharacterBody2D

@export var speed = 200

func _ready():
	$AnimatedSprite2D.play("player_idle_animation")

func get_input():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	move_and_slide()
	update_animation()
	update_facing_direction()

# Function to update the animation based on movement
func update_animation():
	if velocity.length() > 0:
		if not $AnimatedSprite2D.is_playing() or $AnimatedSprite2D.animation != "player_sprint_animation":
			$AnimatedSprite2D.play("player_sprint_animation")
	else:
		if not $AnimatedSprite2D.is_playing() or $AnimatedSprite2D.animation != "player_idle_animation":
			$AnimatedSprite2D.play("player_idle_animation")

# Function to update the facing direction based on horizontal movement
func update_facing_direction():
	if velocity.x != 0:
		$AnimatedSprite2D.flip_h = velocity.x < 0

func _on_item_picked_up():
	print( "[Player] receieved an item" )
