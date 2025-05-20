extends Node2D

@export var MAP_HEIGHT: int
@export var MAP_WIDTH: int


func _ready() -> void:
	var noise_grid = make_noise_grid(60)
	apply_cellular_automata(noise_grid, 8)
	print_noise_grid(noise_grid)

func initialize_2d_array(width: int, height: int, default_value = null) -> Array:
	var new_2d_array: Array = []

	for y in range(height): 
		var row: Array = []
		row.resize(width)
		row.fill(default_value) 
		
		new_2d_array.append(row)
		
	return new_2d_array
	
# Step 1
func make_noise_grid(density: int):
	if MAP_HEIGHT == null:
		return
	if MAP_WIDTH == null:
		return
	var noise_grid = initialize_2d_array(MAP_HEIGHT, MAP_WIDTH)
	for i in range(MAP_HEIGHT):
		for j in range(MAP_WIDTH):
			var random = randi() % 100 + 1

			if random > density:
				noise_grid[i][j] = ' '
			else:
				noise_grid[i][j] = 'X'
	return noise_grid
	
# Step 2
func apply_cellular_automata(grid: Array, iterations: int) -> void:
	for i in range(iterations):
		var grid_iteration: Array = grid.duplicate(true)

		for j in range(MAP_HEIGHT):
			for k in range(MAP_WIDTH): 
				var neighbor_wall_count := 0
				var border := false

				for y in range(j - 1, j + 2): 
					for x in range(k - 1, k + 2):
						if y >= 0 and x >= 0 and y < MAP_HEIGHT and x < MAP_WIDTH:
							if y != j or x != k:
								if grid_iteration[y][x] == 'X':
									neighbor_wall_count += 1
						else:
							border = true
				
				if neighbor_wall_count > 4 or border:
					grid[j][k] = 'X'
				else:
					grid[j][k] = ' '


func is_within_map_bounds(x: int, y: int):
	if x < 0: return false
	if x >= MAP_WIDTH: return false
	if y < 0: return false
	if y >= MAP_HEIGHT: return false
	return true
	
func print_noise_grid(noise_grid: Array):
	var grid: String = ""
	for i in range(noise_grid.size() -1):
		var line: String = ""
		for j in range(noise_grid[i].size() -1):
			line += noise_grid[i][j]
		grid += line + "\n"
	print(grid)
