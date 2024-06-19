extends Area2D

signal item_picked_up

func _ready():
	self.body_entered.connect( _on_body_enterered )

func _on_body_enterered( body: Node ):
	if body.is_in_group( "player" ):
		print( "the player picked up the item" )
		queue_free()
