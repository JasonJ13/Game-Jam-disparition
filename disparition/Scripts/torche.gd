extends Node2D


@onready var animation : AnimatedSprite2D = $AnimatedSprite2D
@onready var source : PointLight2D = $source

@export_enum("nord","sud","est","ouest") var side : String = "coté"

func _ready() -> void:
	orientation(side)


func _process(delta: float) -> void:
	
	var source_level = source.energy
	
	if source_level < 0.4 :
		source_level += 0.05
	
	elif source_level > 0.6 :
		source_level -= 0.05
	
	else : 
		var al = randi() % 2
		
		if al == 0 :
			source_level += 1 * delta *2
		else :
			source_level -= 1 * delta *2
	
	source.energy = source_level


func orientation(face : String)  -> void :
	animation.play(face)
