extends Node
class_name Niveau

var player : CharacterBody2D
var debut : Node2D


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func init_level(p : Node2D) -> void :
	debut = $debut
	
	player = p
	player.set_pos(debut.position)
	



func zone_fin_atteinte(body: Node2D) -> void:

	get_parent().level_suivant()


func get_debut() -> Vector2 :
	return debut.position
