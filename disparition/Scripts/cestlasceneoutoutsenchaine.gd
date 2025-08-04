extends Node2D

@export var nmb_niveau = 7

@onready var player : Node2D = $Player_main

var niveau_indice = 0
var niveau_act
var niveau : Array[PackedScene] = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	var str_niv
	for i in range (nmb_niveau) :
		str_niv = "res://Scenes/modele_niveau/niveau "+str(i)+".tscn"
		niveau.append(load(str_niv))
	
	niveau_act = niveau[0].instantiate()
	niveau_act.init_level(player)
	add_child(niveau_act)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func level_suivant() -> void:

	if niveau_indice == 0 :
		niveau_act.queue_free()
		niveau_indice += 1

		niveau_act = niveau[niveau_indice].instantiate()

		niveau_act.init_level(player)
		add_child(niveau_act)
