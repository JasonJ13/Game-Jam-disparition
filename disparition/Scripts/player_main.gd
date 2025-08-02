class_name Player_main extends Node2D


signal mort(body)

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func player_die():
	mort.emit(self)
