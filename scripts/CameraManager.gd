extends Camera2D

@export var camera_zoom: int = 1
@export var character_body: CharacterBody2D
var offset_factor = 0.1
var max_offset_distance = 200

var target_zoom: Vector2
var zoom_speed: float = 10

func _ready():
	target_zoom = Vector2(camera_zoom, camera_zoom)
	zoom = target_zoom

func _input(event):
	# Check for zoom in and zoom out actions
	if Input.is_action_just_pressed("camera_zoom_in"):
		target_zoom += Vector2(2, 2)
	elif Input.is_action_just_pressed("camera_zoom_out"):
		if target_zoom >= Vector2(2, 2):
			target_zoom -= Vector2(2, 2)

func _process(delta):
	# Interpolate the zoom value towards the target zoom value
	zoom = zoom.lerp(target_zoom, zoom_speed * delta)
