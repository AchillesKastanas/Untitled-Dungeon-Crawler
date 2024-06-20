extends Resource

class_name Item

# Define item properties
@export var name: String
@export var description: String
@export var scene_path: String

func _init(name: String, description: String, scene_path: String ):
	self.name = name
	self.description = description
	self.scene_path = scene_path

func render_item() -> Area2D:
	# Initialise the scene
	var scene: PackedScene = load( self.scene_path )
	# TODO - Programmatically transfer data to the scene
	var instanciated_scene = scene.instantiate()
	
	return instanciated_scene
