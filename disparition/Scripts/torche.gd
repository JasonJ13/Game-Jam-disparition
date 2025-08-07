extends Node2D


@onready var animation : AnimatedSprite2D = $AnimatedSprite2D
@onready var source : PointLight2D = $source

@export_enum("nord","sud","est","ouest") var side : String = "coté"

var numberOnLight = 0

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


func _on_zone_detection_body_entered(body: Node2D) -> void:
	if body is PlayerBody:
		body.change_visibilte(true)
		body.torche_count+=1
		


func _on_zone_detection_body_exited(body: Node2D) -> void:
	if body is PlayerBody:
		body.torche_count-=1
		if body.torche_count==0:
			body.change_visibilte(false)
		
