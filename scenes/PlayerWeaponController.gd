extends Node2D

@export var player_weapon: PackedScene
var character_body_node
var weapon_instance

func _ready():
	# Check if the player_weapon PackedScene is set
	if player_weapon:
		# Instance the PackedScene
		weapon_instance = player_weapon.instantiate()
		character_body_node = get_node( "../CharacterBody2D" )
	else:
		print("Player weapon scene is not assigned.")

func _input(event):
	# Check for zoom in and zoom out actions
	if Input.is_action_just_pressed( "player_attack" ) and get_child_count() == 0:
		add_child( weapon_instance )
	elif Input.is_action_just_released( "player_attack" ):
		remove_child( weapon_instance )

func _physics_process(delta):
	if get_child_count() > 0:
		weapon_instance.position = character_body_node.position
