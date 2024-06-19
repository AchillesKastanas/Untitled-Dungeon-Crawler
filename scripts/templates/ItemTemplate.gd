extends Resource

class_name ItemTemplate

# Define item properties
@export var name: String
@export var description: String
@export var icon: Texture
@export var item_type: String
@export var stackable: bool
@export var max_stack_size: int = 1
