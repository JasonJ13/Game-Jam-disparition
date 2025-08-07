extends Node2D

@export var nmb_niveau = 12

@onready var player : Node2D = $Player
@onready var disparition: AudioStreamPlayer2D = $disparition

var niveau_indice = 0
var niveau_act
var niveau : Array[PackedScene] = []

var sort_sprite_preload = preload("res://Scenes/sort_sprite.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	var str_niv
	for i in range (nmb_niveau) :
		str_niv = "res://Scenes/modele_niveau/niveau "+str(i)+".tscn"
		niveau.append(load(str_niv))
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func new_level() -> void :
	
	player.position = Vector2(0,0)
	
	if niveau_indice == 12 :
		print('bravo') 
		queue_free()
	else :
		if niveau_indice != 0 :
			niveau_act.queue_free()
		
		
		niveau_act = niveau[niveau_indice].instantiate()
		
		niveau_act.init_level(player)
		player.position = niveau_act.get_debut()
			
		add_child(niveau_act)
		
		niveau_indice += 1
	


func level_suivant(body : Node2D) -> void:
	if body == player :
		call_deferred("new_level")



func disparition_mur(position_mur : Vector2i) -> bool:
	
	player.sort_possible = true
	disparition.play()
	return niveau_act.disparition_mur(position_mur)

func disparition_corps(corps : Node2D) :
	if corps != player :
		niveau_act.disparition_corps(corps)
		player.sort_possible = true
		disparition.play()


func ocus_fail() :
	player.sort_possible = true

	
func ajouter_sort_couche(indice : int, angle : float, p : Vector2) :
	var nouveau_sprit_sort = sort_sprite_preload.instantiate()
	
	nouveau_sprit_sort.init(indice, angle, p)
	
	add_child(nouveau_sprit_sort)


func _on_play_pressed() -> void:
	new_level()


func _on_level_pressed() -> void:
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	get_tree().quit()
