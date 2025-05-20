extends Node2D

@export var MAP_HEIGHT: int
@export var MAP_WIDTH: int


func _ready() -> void:
	var noise_grid = make_noise_grid(60)
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
	for i in range(MAP_HEIGHT -1):
		for j in range(MAP_WIDTH -1):
			var random = randi() % 100 + 1

			if random > density:
				noise_grid[i][j] = ' '
			else:
				noise_grid[i][j] = 'X'
	return noise_grid
	
# Step 2
func apply_cellular_automaton(grid: Array, count: int):
	pass
	
func print_noise_grid(noise_grid: Array):
	var grid: String = ""
	for i in range(noise_grid.size() -1):
		var line: String = ""
		for j in range(noise_grid[i].size() -1):
			line += noise_grid[i][j]
		grid += line + "\n"
	print(grid)
