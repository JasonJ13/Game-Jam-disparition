extends AnimatedSprite2D

@onready var lumiere = $lumiere

func init(sprite : int, angle : float, p : Vector2) -> void :
	play('sort'+str(sprite))
	rotation = angle
	position = p

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	modulate.a -= 0.01
	lumiere.energy -= 0.002
	
	if modulate.a < 0 :
		queue_free()
