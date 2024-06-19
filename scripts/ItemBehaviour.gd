extends Area2D

@export var ItemResource: ItemTemplate

# Player Gear Slots
enum GearSlot {
	HELMET,
	ARMOUR,
	BACKPACK,
	WEAPON,
}

signal item_picked_up( gearSlot, item )

func _ready():
	self.body_entered.connect( _on_body_enterered )

func _on_body_enterered( body: Node ):
	if body.is_in_group( "player" ):
		print( "the item was picked up" )
		
		item_picked_up.emit( GearSlot.WEAPON, ItemResource )
		# Remove the item from the scene tree
		queue_free()
