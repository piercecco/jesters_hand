extends Node

var is_turn_going := false
var turn_timer := 0.0
var turn_timer_delay := 0.75
var entity_count := 0
var current_entity := 0


func end_turn():
	current_entity = 0
	is_turn_going = true
	entity_count = len(EntityManager.level_entities)
	PlayerManager.process_turn()

func _process(delta: float) -> void:
	
	if current_entity >= entity_count:
		is_turn_going = false
	
	if is_turn_going:
		turn_timer += delta
		if turn_timer >= turn_timer_delay:
			turn_timer = 0.0
			if current_entity < len(EntityManager.level_entities):
				if EntityManager.level_entities[current_entity].health > 0:
					EntityManager.level_entities[current_entity].process_turn()
					EntityManager.level_entities[current_entity].attack_player()
					current_entity += 1
				else:
					EntityManager.level_entities[current_entity].kill()
			else:
				is_turn_going = false
