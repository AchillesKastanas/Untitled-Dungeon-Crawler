extends Node2D

@export var item: Resource
signal _item_picked_up( item: Resource )

func _ready():
	var name: String = item.get( "name" )
	var texture: Texture2D = item.get( "texture" )
	var damage: float = item.get( "damage" )
	
	$ItemSprite.texture = texture

func _on_area_2d_body_entered(body):
	if body.is_in_group( "player" ):
		_item_picked_up.emit( item )
		queue_free()
