extends Node2D

@onready var tiles : TileMapLayer= $TileMapLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func disparition_mur(position_mur : Vector2i) -> void :
	var altasneighbor
	tiles.set_cell(position_mur, 0, Vector2i(2,4))
	for neighbor in tiles.get_surrounding_cells(position_mur) :
		altasneighbor = tiles.get_cell_atlas_coords(neighbor)
		if altasneighbor.x > 3 || altasneighbor.y < 4 :
			tiles.erase_cell(neighbor)
			tiles.set_cells_terrain_connect([neighbor],0,0)
