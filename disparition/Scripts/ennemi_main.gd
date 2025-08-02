class_name Ennemi_Main extends Node2D

@export var EstEnnemiFixe :bool = false
@onready var ennemi: Ennemi = $Ennemi

enum State{LOOK, WALK, AGGRO}



var currentState = State.LOOK
var player:CharacterBody2D
var playerDetected:bool
var playerInSight:bool

var direction:Vector2

func _ready() -> void:
	direction=Vector2.RIGHT


func _process(delta: float) -> void:
	match currentState:
		State.LOOK :
			ennemi.velocity=Vector2.ZERO
			if playerDetected:
				sight_check()
				if playerInSight:
					currentState=change_state(State.AGGRO)
			ennemi.look_around(direction)
		
	if playerDetected:
		sight_check()

func change_state(state):
	currentState=state


func _on_sight_body_entered(body: Node2D) -> void:
	if body is PlayerBody:
		player=body
		print("Player détecté")
		playerDetected=true


func _on_sight_body_exited(body: Node2D) -> void:
	print("player sorti")
	playerDetected=false
	playerInSight=false

func sight_check():
	var space_state = get_world_2d().direct_space_state
	var sightParameters = PhysicsRayQueryParameters2D.create(global_position,player.global_position,ennemi.collision_mask,[self,Ennemi_Main])
	var sight_check = space_state.intersect_ray(sightParameters)
	if sight_check["collider"] is PlayerBody:
		playerInSight=true
	else:
		playerInSight=false
	
