extends Area2D


@export var ItemResource: Item
signal item_picked_up()


func _ready():
	self.body_entered.connect( _on_body_enterered )

func _on_body_enterered( body: Node ):
	if body.is_in_group( "player" ):
		item_picked_up.emit()
		# Remove the item from the scene tree
		queue_free()
