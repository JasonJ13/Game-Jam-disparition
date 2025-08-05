extends Node
class_name Niveau

var player : CharacterBody2D
var debut : Node2D
var tiles : TileMapLayer

var tuile_effacee : Vector2i
var est_tuile_effacee : bool
var altasneighbor : Vector2i

var corps_efface : Node2D
var est_corps_efface : bool

func init_level(p : Node2D) -> void :
	debut = $debut
	
	player = p
	print(player)
	player.set_pos(debut.position)
	

func zone_fin_atteinte(body: Node2D) -> void:

	get_parent().level_suivant(body)


func get_debut() -> Vector2 :
	return debut.position


func reaparition() -> void :
	if est_tuile_effacee :
		est_tuile_effacee = false
		
		tiles.set_cell(tuile_effacee, 0,Vector2i(0,0))
		
		for neighbor in tiles.get_surrounding_cells(tuile_effacee) :
			altasneighbor = tiles.get_cell_atlas_coords(neighbor)
			if altasneighbor.x > 3 || altasneighbor.y < 4 :
				tiles.erase_cell(neighbor)
				tiles.set_cells_terrain_connect([neighbor],0,0)
		
		tiles.set_cells_terrain_connect([tuile_effacee],0,0)
	
	elif est_corps_efface :
		est_corps_efface = false
		
		corps_efface.set_process(true)
		corps_efface.show()
		



func disparition_mur(position_mur : Vector2i) -> void :
	
	tiles = $TileMapLayer

	reaparition()
	est_tuile_effacee = true
	
	tiles.set_cell(position_mur, 0, Vector2i(2,4))
	for neighbor in tiles.get_surrounding_cells(position_mur) :
		altasneighbor = tiles.get_cell_atlas_coords(neighbor)
		if altasneighbor.x > 3 || altasneighbor.y < 4 :
			tiles.erase_cell(neighbor)
			tiles.set_cells_terrain_connect([neighbor],0,0)
	tuile_effacee = position_mur

func disparition_corps(body : Node2D) -> void :
	tiles = $TileMapLayer
	
	if body != tiles :
	
		reaparition()
		est_corps_efface = true
		
		corps_efface = body
		body.set_process(false)
		body.hide()
	
