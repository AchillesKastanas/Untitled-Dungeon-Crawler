extends Node2D


# Block size setup
const map_size = 5    # rooms
const room_size = 32  # blocks
# Map size setup
var map_dimensions = Vector2( map_size, map_size )
# Room size setup
var room_dimensions = Vector2( room_size, room_size )

@onready var tile_map = $"../../TileMap"

func _ready():
	print( "Room Manager Ready" )
	
# Loads the requested tile from the tilemap based on Atlas coordinates ( tile_id )
func find_tile_id( tile_id: Vector2i ) -> Vector2i:
	var tileset_source = tile_map.tile_set.get_source(0)  # Assuming tile_map and its tile_set are already defined
	
	var tileset_tiles_count = tileset_source.get_tiles_count()
	
	for i in range( tileset_tiles_count ):
		var current_tile_id = tileset_source.get_tile_id( i )
		
		if current_tile_id == tile_id:
			return tile_id
	
	return Vector2i( -1, -1 )  # Tile not found

# Draw Room
func draw_room( room_starting_coords: Vector2, room_ending_coords: Vector2, entrance_coords: Vector2, is_room_empty: bool ):
	for room_pos_x in range( room_starting_coords.x, room_ending_coords.x ):
		for room_pos_y in range( room_starting_coords.y, room_ending_coords.y ):
			# Block position relative to room
			var block_pos = Vector2( room_pos_x, room_pos_y )
			# Wall -> Is on the outer part of the room
			var is_wall = false
			var is_door = false
			if room_pos_x == room_starting_coords.x or room_pos_x == ( room_starting_coords.x + room_dimensions.x - 1 ) or room_pos_y == room_starting_coords.y or room_pos_y == ( room_starting_coords.y + room_dimensions.y - 1 ):
				is_wall = true
			# TODO - USE ACTUALL WORLD COORDS
			if block_pos == entrance_coords:
				is_door = true
			draw_block( block_pos, is_wall, is_door, is_room_empty )

func draw_block( block_pos: Vector2, is_wall: bool, is_door: bool, is_room_empty: bool ):
	const layer_floor = 0
	const layer_walls = 1
	var tile_id = -1
	var layer = -1 
	
	if not is_room_empty:
		if is_door:
			tile_id = find_tile_id( Vector2i( 10, 1 ) )   # Atlas coordinates for doors
			layer = layer_walls
		elif is_wall:
			tile_id = find_tile_id( Vector2i( 0, 2 ) )   # Atlas coordinates for walls
			layer = layer_walls
		else:
			tile_id = find_tile_id( Vector2i( 56, 1 ) )   # Atlas coordinates for floors
			layer = layer_floor
	else:
		var random_value = randi() % 100 # 0 - 100
		const void_spawn_chance = 90
		
		if random_value <= void_spawn_chance:
			# 80% change
			tile_id = find_tile_id( Vector2i( 16, 0 ) )   # Atlas coordinates for empty rooms / void
			layer = layer_floor
		else:
			# 20% chance
			tile_id = find_tile_id( Vector2i( 2, 34 ) )   # Atlas coordinates for empty rooms / trees
			layer = layer_floor
	
	if tile_id != Vector2i( -1, -1 ):
		tile_map.set_cell( layer, block_pos, 0, tile_id )
