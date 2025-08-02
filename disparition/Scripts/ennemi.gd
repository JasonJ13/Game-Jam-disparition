extends CharacterBody2D


const SPEED = 300.0

var destination:Vector2i
var current_state = State.LOOK

enum State{LOOK,PATH,AGGRO}

func set_dest(dest):
	destination=dest

func _physics_process(delta: float) -> void:
	match current_state :
		State.LOOK :
			velocity=Vector2.ZERO
		State.PATH :
			velocity=SPEED*((global_position-Vector2(destination)*32).normalized())
			
			
	move_and_slide()
	
func _process(delta: float) -> void:
	if (Vector2i(global_position)/32)==destination:
		change_state(State.LOOK)
		
func change_state(state):
	current_state=state
