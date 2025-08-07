extends Node


var niveau_debut = preload("res://Scenes/modele_niveau/niveauxenchianes.tscn")

@onready var menu = $Menu


func leave_game() -> void:
	get_tree().quit()


func Play() -> void:
	var game_begin = niveau_debut.instantiate()
	
	menu.hide()
	menu.set_process_mode(Node.PROCESS_MODE_DISABLED)
	
	add_child(game_begin)
