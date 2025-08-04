class_name Player_main extends Node2D



func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass

func player_die():
	print("mort")
	
func set_pos(new_pos : Vector2) -> void :
	position = new_pos
