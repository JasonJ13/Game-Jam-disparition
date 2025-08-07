extends RigidBody2D

var debut : Vector2

var compt_frame : int = 0
var ind_sprite : int = 0
var angle : float = 0

var previous_velo : Vector2
var previous_pos : Vector2

func init(cf : Vector2, a : float) -> void :
	constant_force = cf
	linear_velocity = cf
	angle = a
	previous_velo = cf

	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if linear_velocity.distance_to(previous_velo) > 20 :
		if get_parent().disparition_mur(Vector2i(position)/64) :
			queue_free()
	
	previous_velo = linear_velocity
	
	if position.x <0 || position.y < 0 || position.x > 1000 || position.y> 700 :
		get_parent().ocus_fail()
		queue_free()
	

	if compt_frame == 0 :
		get_parent().ajouter_sort_couche(ind_sprite,angle,position)
	compt_frame += 1
	if int(delta*1000*40/(69*2)) != 0 :
		compt_frame = compt_frame % int(delta*1000*40/(69*2))



func ocuspocusbody(body: Node2D) -> void:
	if body != self  :
		get_parent().disparition_corps(body)
		queue_free()
