extends Node2D

# Player Gear Slots
enum GearSlot {
	HELMET,
	ARMOUR,
	BACKPACK,
	WEAPON,
}

# Inventory Dictionary
var inventory = {
	GearSlot.HELMET: null,
	GearSlot.ARMOUR: null,
	GearSlot.BACKPACK: null,
	GearSlot.WEAPON: null,
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Add item to the players inventory
func equip_item( gearSlot: GearSlot, item: ItemTemplate ) -> bool:
	if gearSlot in inventory:
		if inventory[gearSlot] == null:
			inventory[gearSlot] = item
			print( "Added item: ", item.name, " to slot: ", gearSlot )
			return true
		else:
			print( "Slot: ", gearSlot, " already occupied." )
	else:
		print("Invalid slot: ", gearSlot )
	return false

# Remove item from the players inventory
func remove_item( gearSlot: GearSlot ) -> bool:
	if gearSlot in inventory:
		inventory[gearSlot] = null
		return true
	else:
		print("Invalid slot.")
	return false

# Triggers whenever an item is picked up
func _on_item_picked_up( gearSlot: GearSlot, item: ItemTemplate ):
	equip_item( gearSlot, item  )
