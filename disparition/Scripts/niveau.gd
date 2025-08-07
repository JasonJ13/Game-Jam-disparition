extends Node
class_name Niveau

@onready var son_escalier: AudioStreamPlayer2D = $"son escalier"
@onready var pas_princesses: AudioStreamPlayer = $pas_princesses

var playing_pas=false

var player : CharacterBody2D
var debut : Node2D
var tiles : TileMapLayer
var torches : Node

var tuile_effacee : Vector2i
var est_tuile_effacee : bool
var altasvoisin : Vector2i

var corps_efface : Node2D
var est_corps_efface : bool

var level_finissable = false

func init_level(p : Node2D) -> void :
	
	debut = $debut

	tiles = $TileMapLayer
	torches = $Torche
	
	player = p
	player.set_pos(debut.position)
	
	while player.position != debut.position :
		pass
	level_finissable = true

func zone_fin_atteinte(body: Node2D) -> void:
	if level_finissable :
		son_escalier.play()
		get_parent().level_suivant(body)


func get_debut() -> Vector2 :
	return debut.position


func reaparition() -> void :
	if est_tuile_effacee :
		est_tuile_effacee = false
		
		tiles.set_cell(tuile_effacee, 0,Vector2i(0,3))
		for voisin in tiles.get_surrounding_cells(tuile_effacee) :
			altasvoisin = tiles.get_cell_atlas_coords(voisin)
			
			if ( altasvoisin.x > 3 || altasvoisin.y < 4) && altasvoisin != Vector2i(-1,-1):
				tiles.set_cells_terrain_connect([voisin],0,0, false)
				
		for t in torches.get_children() :
			if (Vector2i(t.position)/64 == tuile_effacee) :
				t.show()
				
		if Vector2i(player.position)/64 == tuile_effacee && tiles.get_cell_atlas_coords(tuile_effacee).x > 3 :
			player.player_touched() 
		

	
	elif est_corps_efface :
		est_corps_efface = false
		
		corps_efface.apparue()
		
func _process(delta: float) -> void:
	play_pas_princesses()


func disparition_mur(position_mur : Vector2i) -> bool :
	
	var atlas_mur = tiles.get_cell_atlas_coords(position_mur)
	if ( atlas_mur.x < 4 && atlas_mur.y > 3) :
		return false

	if position_mur.x > 0 && position_mur.x < 12 && position_mur.y >= 0 && position_mur.y < 7:
		reaparition()
		est_tuile_effacee = true

		tiles.set_cell(position_mur, 0, Vector2i(2,4))
		for voisin in tiles.get_surrounding_cells(position_mur) :
			altasvoisin = tiles.get_cell_atlas_coords(voisin)
			if ( altasvoisin.x > 3 || altasvoisin.y < 4) :
				tiles.set_cells_terrain_connect([voisin],0,-1, false)
				tiles.set_cells_terrain_connect([voisin],0,0, false)
		tuile_effacee = position_mur
		
		for t in torches.get_children() :
			if (Vector2i(t.position)/64 == position_mur) :
				t.hide()
			
	return true

func play_pas_princesses():
	var children = get_children()
	for child in children:
		if child is Ennemi:
			if !child.est_disparue and !child.currentState != child.State.LOOK and !playing_pas:
				pas_princesses.play()
				playing_pas=true
				await pas_princesses.finished
				playing_pas=false
		


func disparition_corps(body : Node2D) -> void :
	tiles = $TileMapLayer
	
	if body != tiles :
	
		reaparition()
		est_corps_efface = true
		
		corps_efface = body
		body.disparue()
	
