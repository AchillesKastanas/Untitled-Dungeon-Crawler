extends Item
class_name Sword

# Define item properties
@export var damage: int
var item: Item

func _init(name: String = "", description: String = "", scene_path: String = "", damage: int = 0 ):
	self.item = Item.new( name, description, scene_path )
	self.damage = damage
