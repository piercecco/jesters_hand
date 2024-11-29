extends Control

var artifact_types = {
	"crystal_heart" = {
		"display_name": "Crystal Heart",
		"tooltip_text": "Permanently increments max HP. Stronger than a blood vial.",
		"price": 75.0,
	},
	"blood_vial" = {
		"display_name": "Blood Vial",
		"tooltip_text": "Permanently increments max HP.",
		"price": 35.0,
	},
	"stone_scute" = {
		"display_name": "Stone Scute",
		"tooltip_text": "Permanently increments defense.",
		"price": 25.0,
	},
	"warp_spell" = {
		"display_name": "Warp Spell",
		"tooltip_text": "Permanently increments minimum dodge chance.",
		"price": 25.0,
	},
	"shield_apparatus" = {
		"display_name": "Shield Apparatus",
		"tooltip_text": "Lets you start the next encounter with more shield.",
		"price": 35.0,
	},
	"energy_core" = {
		"display_name": "Energy Core",
		"tooltip_text": "Permanently increments maximum Energy by 1.",
		"price": 40.0,
	},
}

var selected_id := 0
var selected_item := ""
var price := 0.0
var has_been_bought := false

var sinwavepos := 0.0
var sinwavemod := 0.25
var sinwaveaplifier := 5.0

func _ready() -> void:
	$BoughtLabel.hide()
	selected_id = randi_range(0, len(artifact_types.keys())-1)
	selected_item = artifact_types.keys()[selected_id]
	$Sprite2D.frame = selected_id
	price = artifact_types[selected_item]["price"]
	$ArtifactCost.text = str(price) + "g"
	$ArtifactTitle.text = artifact_types[selected_item]["display_name"]
	$ArtifactTooltip.text = artifact_types[selected_item]["tooltip_text"]


func _process(delta: float) -> void:
	if selected_item == "crystal_heart":
		$TranformLabel.text = str(PlayerManager.max_health) + " -> " + str(PlayerManager.max_health + 25)
	elif selected_item == "blood_vial":
		$TranformLabel.text = str(PlayerManager.max_health) + " -> " + str(PlayerManager.max_health + 10)
	elif selected_item == "stone_scute":
		$TranformLabel.text = str(PlayerManager.base_defense) + " -> " + str(PlayerManager.base_defense + 2)
	elif selected_item == "warp_spell":
		$TranformLabel.text = str(PlayerManager.base_dodge) + " -> " + str(PlayerManager.base_dodge + 2.5)
	elif selected_item == "shield_apparatus":
		$TranformLabel.text = str(PlayerManager.shield) + " -> " + str(PlayerManager.shield + 10)
	elif selected_item == "energy_core":
		$TranformLabel.text = str(PlayerManager.max_energy) + " -> " + str(PlayerManager.max_energy + 1)
	
	sinwavepos += delta
	$Sprite2D.position.y = 35 + sin(sinwavepos*3.14*sinwavemod)*sinwaveaplifier


func _on_buy_button_pressed() -> void:
	if PlayerManager.gold >= price and !has_been_bought:
		has_been_bought = true
		$BoughtLabel.show()
		PlayerManager.gold -= price
		if selected_item == "crystal_heart":
			PlayerManager.max_health += 25
		elif selected_item == "blood_vial":
			PlayerManager.max_health += 10
		elif selected_item == "stone_scute":
			PlayerManager.base_defense += 2
		elif selected_item == "warp_spell":
			PlayerManager.base_dodge += 2.5
		elif selected_item == "shield_apparatus":
			PlayerManager.shield += 10
		elif selected_item == "energy_core":
			PlayerManager.max_energy += 1
