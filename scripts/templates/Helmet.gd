extends Item
class_name Helmet

# Define item properties
@export var defence: int
var item: Item

func _init(name: String, description: String, scene_path: String, defence: int ):
	self.item = Item.new( name, description, scene_path )
	self.defence = defence
