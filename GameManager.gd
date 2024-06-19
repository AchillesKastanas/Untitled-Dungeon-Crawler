extends Node2D

func _ready():
	# Check if items have dropped in the group
	var dropped_items = get_tree().get_nodes_in_group("dropped_item")
	var player = get_node( "Player/CharacterBody2D" )	
	if dropped_items.size() > 0:
		for dropped_item in dropped_items:
			dropped_item.connect( "item_picked_up", player._on_item_picked_up )
