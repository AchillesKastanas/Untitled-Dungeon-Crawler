extends Node2D

@export var helmet: Resource
@export var armour: Resource
@export var weapon: Resource
@export var slots: Array = []

# Add item to backpack
func add_to_backpack(item: Resource):
	print( "[Backpack] Added Item: ", item.get( "name" ) )
	slots.append(item)

# Equip items
func equip_helmet(item: Resource):
	helmet = item

func equip_armour(item: Resource):
	armour = item

func equip_weapon(item: Resource):
	weapon = item

# Unequip items
func unequip_helmet():
	helmet = null

func unequip_armour():
	armour = null

func unequip_weapon():
	weapon = null

# Triggers whenever an item is picked up
func _on_item_picked_up():
	#equip_item( gearSlot, item  )
	print( "signal recieved by inventory" )
