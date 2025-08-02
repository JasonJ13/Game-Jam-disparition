extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for torche in $torches/torche_nord.get_children() :
		torche.orientation('nord')
	for torche in $torches/torche_sud.get_children() :
		torche.orientation('sud')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
