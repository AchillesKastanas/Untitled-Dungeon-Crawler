extends Node2D



func _on_item_picked_up( item: Resource ):
	get_node( "InventoryManager" ).add_to_backpack( item )
