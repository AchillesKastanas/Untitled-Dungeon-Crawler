extends Node2D

class_name Grid

# Block size setup
const map_size = 5    # rooms
const room_size = 32  # blocks
# Map size setup
var map_dimensions = Vector2( map_size, map_size )
# Room size setup
var room_dimensions = Vector2( room_size, room_size )


func _ready():
	# Room manager reference
	var room_manager = get_node( "RoomGenerator" )

	# Start the generation
	if room_manager:
		var generated_map_rooms = generate_map()
		draw_map(generated_map_rooms, room_manager)
	else:
		print( "RoomManager node not found or not ready yet ? " )

# Room coordinates to actual World coordinates convertion
func room_to_world_coords( room_position: Vector2 ) -> Vector2:
	return room_position * room_size

# Look for Vector2 in a Vector2 array
func is_vector2_in_vector2array( vector2, vector2array ):
	for vec in vector2array:
		if vec == vector2:
			return true
	return false

# Draw map
func draw_map( generated_map_rooms: Array[Vector2], room_manager ):
	for room_pos_x in range( map_dimensions.x ):
		for room_pos_y in range( map_dimensions.y ):
			var is_room_empty = true
			# Check if room is empty based on the generated_map_roomns
			if is_vector2_in_vector2array( Vector2( room_pos_x, room_pos_y ), generated_map_rooms ):
				print( "Room exists: ", Vector2( room_pos_x, room_pos_y ) )
				is_room_empty = false
			var room_coords = room_to_world_coords( Vector2( room_pos_x, room_pos_y ) )
			# Current Room coordinates
			var room_starting_coords = Vector2( room_coords.x, room_coords.y )
			var room_ending_coords = room_starting_coords + room_dimensions
			# Pick a random entrance point for each room
			var room_entrance_coords = Vector2( room_starting_coords.x + 2, room_starting_coords.y )
			# Check if 
			room_manager.draw_room( room_starting_coords, room_ending_coords, room_entrance_coords, is_room_empty )

func generate_map() -> Array[Vector2]:
	var created_rooms: Array[Vector2] = []
	# Get a random entry point
	var map_entry_point = get_map_entry_point()
	# Get a random entry point
	var map_exit_point = get_map_exit_point( map_entry_point )
	# Create a path from entry to exit
	created_rooms = get_map_paths( map_entry_point, map_exit_point )
	
	return created_rooms

const MAX_GRID_WIDTH = 5
const MAX_GRID_HEIGHT = 5

func get_map_entry_point():
	# Decide if the point will be vertical or horizontal
	var point_orientation = ["vertical", "horizontal"]
	var random_orientation = point_orientation[randi() % point_orientation.size()]
	var x = -1
	var y = -1
	
	if random_orientation == "vertical":
		# Set X to be 0 or MAX_GRID_HEIGHT - 1
		x = randi() % 2 * (MAX_GRID_HEIGHT - 1)
		# Set Y to be a random number from 0 to MAX_GRID_HEIGHT - 1
		y = randi() % (MAX_GRID_HEIGHT - 1)
	else:
		# Set Y to be 0 or MAX_GRID_WIDTH - 1
		y = randi() % 2 * (MAX_GRID_WIDTH - 1)
		# Set X to be a random number from 0 to MAX_GRID_WIDTH - 1
		x = randi() % (MAX_GRID_WIDTH - 1)
	
	return Vector2( x, y )

func get_map_exit_point( map_entry_point: Vector2 ):
	# Decide if the point will be vertical or horizontal
	var point_orientation = ["vertical", "horizontal"]
	var random_orientation = point_orientation[randi() % point_orientation.size()]
	var x = map_entry_point.x
	var y = map_entry_point.y
	
	if random_orientation == "vertical":
		while Vector2( x, y ) == map_entry_point:
			# Set X to be 0 or MAX_GRID_HEIGHT - 1
			x = randi() % 2 * (MAX_GRID_HEIGHT - 1)
			# Set Y to be a random number from 0 to MAX_GRID_HEIGHT - 1
			y = randi() % (MAX_GRID_HEIGHT - 1)
	else:
		while Vector2( x, y ) == map_entry_point:
			# Set Y to be 0 or MAX_GRID_WIDTH - 1
			y = randi() % 2 * (MAX_GRID_WIDTH - 1)
			# Set X to be a random number from 0 to MAX_GRID_WIDTH - 1
			x = randi() % (MAX_GRID_WIDTH - 1)
	
	return Vector2( x, y )

func get_map_paths( map_entry_point: Vector2, map_exit_point: Vector2 ) -> Array[Vector2]:
	const moves = [
		Vector2( 0, -1 ), # UP
		Vector2( 0, 1 ),  # DOWN
		Vector2( -1, 0 ), # LEFT
		Vector2( 1, 0 ),  # RIGTH
	]
	# Stores all the visited path rooms in chronological order
	var path_history: Array[Vector2] = [map_entry_point]
	# Stores all the visited path rooms + backtracking data in chronological order ( used for door generation )
	var detailed_path_history: Array[Vector2] = [map_entry_point]
	# Stores the current cursor position
	var current_loop_cursor: Vector2 = map_entry_point
	
	# Loop until the exit is reached
	while not current_loop_cursor == map_exit_point:
		# Stores the already tried moves
		var tried_moves_indexes = []
		# Stores if a new room has been found
		var is_new_room_found = false
		# Try all the available moves
		while not tried_moves_indexes.size() == moves.size():
			# Pick a random move
			var random_move_index = -1
			# Pick a random_move_index that has not been tried
			while random_move_index == -1 or tried_moves_indexes.find( random_move_index ) != -1: 
				random_move_index = randi() % moves.size()
			var random_move = moves[ random_move_index ]
			# Store the picked move index
			tried_moves_indexes.append( random_move_index )
			# Check if room is empty / no wall is present
			#print( "Trying to move from: ", current_loop_cursor, " to: ", current_loop_cursor + random_move )
			var is_room_available = get_is_room_available( current_loop_cursor + random_move, path_history )
			# If the room is available, add it to the path_history, move the current_loop_cursor and break from the while earlier
			if is_room_available:
				#print( "Move succesful, cursor now at: ", current_loop_cursor + random_move )
				var new_room_coords = current_loop_cursor + random_move
				path_history.append( new_room_coords )
				detailed_path_history.append( new_room_coords )
				current_loop_cursor = new_room_coords
				is_new_room_found = true
				break
		# If not found any new rooms, backtrack to the previously visited room and try again
		if not is_new_room_found:
			#print( "No rooms found, backtracking to: ", path_history[path_history.find( current_loop_cursor ) - 1] ) # if this throws out of bounds, debug
			# Go back to the previous room
			detailed_path_history.append( path_history[path_history.find( current_loop_cursor ) - 1] )
			current_loop_cursor = path_history[path_history.find( current_loop_cursor ) - 1]
	print( "Looping done with path -> ", detailed_path_history )
	return detailed_path_history
	# TODO - If it is too simple, add complexity by selecting a random point and branching out

func get_is_room_available( room_cords: Vector2, path_history: Array ):
	var can_path_room = false
	# If room is not out of bounds ( unless it is the exit) + is not in the path history ( already visited )
	if room_cords.x >= 0 and room_cords.x <= MAX_GRID_WIDTH - 1 and room_cords.y >= 0 and room_cords.y <= MAX_GRID_HEIGHT - 1 and path_history.find( room_cords ) == -1:
		can_path_room = true
	
	return can_path_room
