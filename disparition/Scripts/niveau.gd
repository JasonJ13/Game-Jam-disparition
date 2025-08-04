extends Node
class_name Niveau

var player : Player_main

var finissable = false


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func init_level(p : Node2D) -> void :
	var debut : Node2D = $debut
	
	player = p
	print(debut.position)
	player.set_pos(debut.position)
	print(player.position)
	
	finissable = true


func zone_fin_atteinte(body: Node2D) -> void:
	if finissable :
		finissable = false
		get_parent().level_suivant()
