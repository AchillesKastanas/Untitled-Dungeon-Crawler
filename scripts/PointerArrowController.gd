extends Node2D

@export var character_body: CharacterBody2D

func _process(delta):
	var mouse_pos = get_global_mouse_position()
	var character_pos = character_body.global_position
	
	var arrow_angle = ( mouse_pos - character_pos ).normalized()
	rotation = arrow_angle.angle()

func _input(event):
	# Check for zoom in and zoom out actions
	if Input.is_action_pressed("player_attack"):
		hide()
	else:
		show()
