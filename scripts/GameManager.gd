extends Node2D

func _ready():
	# TODO - Transfer to an Item Dropper Manager 
	# Drop an item on the ground for pickups
	var new_dropped_item = load( "res://assets/resources/stone_sword.tres" ) as Resource
	render_item( new_dropped_item )
	
	# Check if items have dropped in the group
	var dropped_items = get_tree().get_nodes_in_group("dropped_item")
	var player_inventory_manager = get_node( "Player/InventoryManager" )	
	if dropped_items.size() > 0:
		for dropped_item in dropped_items:
			dropped_item.connect( "item_picked_up", player_inventory_manager._on_item_picked_up )

func render_item( item: Resource ):
	# TODO - Add an item stat generator
	# TODO - Signal from inner DroppedItem.tscn doesnt work
	#      - Investigate why
	# Load the Item Info
	item.name = "Stone Sword"
	item.description = "Just a sword"
	item.damage = 5
	item.scene_path = "res://scenes/item/DroppedItem.tscn"
	# Instanciate
	var rendered_item_scene = item.render_item()
	# Place Item in the DroppedItems node
	var dropped_items_node = get_node("./LevelContainer/DroppedItems")
	dropped_items_node.add_child( rendered_item_scene )
