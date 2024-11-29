extends Node

var max_health := 200.0
var health := max_health

var shield := 0.0

var weakening_effect := 0.0
var weakening_turns := 0
var bleeding_effect := 0.0
var bleeding_turns := 0
var ablaze_effect := 0.0
var ablaze_turns := 0
var dodge_effect := 1.0
var dodge_turns := 0
var poison_turns := 0

var base_dodge := 10.0
var base_defense := 5.0
var has_dodged := false
var defense_increment := 0.0
var defense_nullifier_turns := 0
var defense_turns := 0
var max_defense_nullifier_turns := 0

var max_energy := 5
var energy_left := max_energy

var is_using_card := false
var using_card := ""
var current_card = ""

var gold := 0.0
var resting_points_visited := 0
var is_in_resting_area := false
var can_loop_map := false
var is_in_boss_area := false

var relapso_card := ""
var is_performing := false



func _ready() -> void:
	pass
	#add_to_group("turn_affected_entity")
	#EntityManager.level_entities.append(self)


func _reset_player():
		
	max_health = 200.0
	health = max_health

	shield = 0.0

	weakening_effect = 0.0
	weakening_turns = 0
	bleeding_effect = 0.0
	bleeding_turns = 0
	ablaze_effect = 0.0
	ablaze_turns = 0
	dodge_effect = 1.0
	dodge_turns = 0
	poison_turns = 0

	base_dodge = 10.0
	base_defense = 5.0
	has_dodged = false
	defense_increment = 0.0
	defense_nullifier_turns = 0
	defense_turns = 0
	max_defense_nullifier_turns = 0

	max_energy = 5
	energy_left = max_energy

	is_using_card = false
	using_card = ""
	current_card = ""

	gold = 0.0
	resting_points_visited = 0
	is_in_resting_area = false
	can_loop_map = false
	is_in_boss_area = false

	relapso_card = ""
	is_performing = false

func process_turn():
	energy_left = max_energy
	if shield > max_health/2:
		shield = max_health/2

	if dodge_turns > 0:
		change_dodge_effect()
	
	if dodge_effect > 10:
		dodge_effect = 10
	
	if weakening_turns > 0:
		descale_weaken_effect()
	
	if bleeding_turns > 0:
		apply_bleeding_damage()
	
	if ablaze_turns > 0:
		apply_flame_damage()
	
	if poison_turns > 0:
		apply_poison_damage()
	
	if defense_turns > 0:
		tick_defense()
	
	if defense_nullifier_turns > 0:
		tick_defense_nullifier()
	
	has_dodged = false

var dodge_label_preload = preload("res://scenes/dodge_text.tscn")

func apply_damage(damage, pure_damage, can_dodge):
	if !(damage <= 0 and pure_damage > 0):
		if randi_range(1, 100) <= (base_dodge*dodge_effect) and can_dodge:
			has_dodged = true
			damage = 0
			var tmp_dodge_label = dodge_label_preload.instantiate()
			tmp_dodge_label.global_position = Vector2(322, 333) + Vector2(randi_range(-25, 25), randi_range(-25, 25))
			get_node("/root/FightingMapArea").add_child(tmp_dodge_label)
		else:
			if shield >= damage:
				shield -= damage
			else:
				damage -= shield
				shield = 0.0
				if defense_nullifier_turns <= 0:
					if weakening_effect < base_defense+defense_increment:
						damage -= randf_range(0.0, base_defense+defense_increment-weakening_effect)
				if damage < 0:
					damage = 0
				health -= damage
	
	if pure_damage < 0:
		pure_damage = 0
	health -= pure_damage

func descale_weaken_effect():
	weakening_turns -= 1
	if weakening_turns <= 0:
		weakening_effect = 0
	
func change_dodge_effect():
	dodge_turns -= 1
	dodge_effect = dodge_effect * (dodge_turns) / (dodge_turns+1)
	if dodge_effect < 1:
		dodge_effect = 1.0
	if dodge_turns <= 0:
		dodge_effect = 1.0

func apply_flame_damage():
	ablaze_turns -= 1
	if bleeding_turns > 0:
		ablaze_turns -= 1
	apply_damage(0, ablaze_effect, false)
	if poison_turns > 0:
		poison_turns -= 1
	if ablaze_turns <= 0:
		ablaze_effect = 0
	
func apply_bleeding_damage():
	bleeding_turns -= 1
	bleeding_effect = 0.1*health
	if poison_turns > 0:
		bleeding_effect += 0.05*health
	apply_damage(0, bleeding_effect, false)
	if bleeding_turns <= 0:
		bleeding_effect = 0

func apply_poison_damage():
	apply_damage(0, poison_turns*10, false)
	poison_turns -= 1

func tick_defense():
	if defense_nullifier_turns <= 0:
		defense_turns -= 1
	if defense_turns <= 0:
		defense_increment = 0

func tick_defense_nullifier():
	if defense_nullifier_turns > max_defense_nullifier_turns:
		max_defense_nullifier_turns = defense_nullifier_turns
	defense_nullifier_turns -= 1
	if defense_nullifier_turns <= 0:
		shield += (base_defense+defense_increment)*max_defense_nullifier_turns*2
		max_defense_nullifier_turns = 0

func apply_shield(amount):
	shield += amount
	if shield > max_health/2:
		shield = max_health/2

func apply_healing(amount):
	health += amount
	if health > max_health:
		health = max_health

func hide_all_active_card_statuses():
	get_node("/root/FightingMapArea/PlayerGUI/").hide_all_active_card_statuses()
