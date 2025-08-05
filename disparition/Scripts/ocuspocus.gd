extends RigidBody2D

@export var direction_mult : bool = true


func init(cf : Vector2) -> void :
	constant_force = cf
	linear_velocity = cf

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if linear_velocity == Vector2(0,0) || (direction_mult && linear_velocity.x * linear_velocity.y == 0) :
		get_parent().disparition_mur(Vector2i(position)/64)
		queue_free()
	
	if position.x <0 || position.y < 0 || position.x > 800 || position.y> 500 :
		get_parent().ocus_fail()
		queue_free()



func ocuspocusbody(body: Node2D) -> void:
	if body != self  :
		get_parent().disparition_corps(body)
		queue_free()
