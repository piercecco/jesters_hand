extends Sprite2D

var id := 0
var is_enabled := false

var tooltip_text := ""
var title_text := ""
var turns_left := 0
var effect_value := 0.0
var is_defense_nullifier := false

func _ready() -> void:
	$".".frame = id
	if is_enabled:
		$".".material.set_shader_parameter("is_enabled", false)
	else:
		$".".material.set_shader_parameter("is_enabled", true)
	tooltip_text = CardManager.effect_tooltips[CardManager.effects_list[id]]
	title_text = CardManager.effects_display_list[id]
	$Panel/MarginContainer/Label.text = title_text + ": \n"
	if id == 1:
		$Panel/MarginContainer/Label.text += "Turns left: " + str(turns_left) + "\n"
	elif id == 2:
		$Panel/MarginContainer/Label.text += "Dodge chance: " + str(effect_value) + "\n"
	elif id == 3:
		$Panel/MarginContainer/Label.text += "Turns left: " + str(turns_left) + "\n"
	elif id == 4:
		$Panel/MarginContainer/Label.text += "Turns left: " + str(turns_left) + "\n"
	elif id == 6:
		$Panel/MarginContainer/Label.text += "Turns left: " + str(turns_left) + "\n"
	elif id == 8:
		$Panel/MarginContainer/Label.text += "Current defense: " + str(effect_value) + "\n"
		$Panel/MarginContainer/Label.text += "Turns left: " + str(turns_left) + "\n"
	
	
	
	$Panel/MarginContainer/Label.text += tooltip_text
	$Panel.scale = Vector2(0.1/(scale.x), 0.1/(scale.y))
	$Panel.hide()

func refresh():
	if is_enabled:
		$".".material.set_shader_parameter("is_enabled", false)
	else:
		$".".material.set_shader_parameter("is_enabled", true)
	
	$Panel/MarginContainer/Label.text = title_text + ": \n"
	if turns_left != 0:
		if id == 1:
			$Panel/MarginContainer/Label.text += "Turns left: " + str(turns_left) + "\n"
		elif id == 2:
			$Panel/MarginContainer/Label.text += "Turns left: " + str(turns_left) + "\n"
			$Panel/MarginContainer/Label.text += "Dodge chance: " + str(snapped(effect_value, 0.1)) + "%\n"
		elif id == 3:
			$Panel/MarginContainer/Label.text += "Turns left: " + str(turns_left) + "\n"
		elif id == 4:
			$Panel/MarginContainer/Label.text += "Turns left: " + str(turns_left) + "\n"
		elif id == 6:
			$Panel/MarginContainer/Label.text += "Turns left: " + str(turns_left) + "\n"
		elif id == 8: # fix this bs
			if PlayerManager.defense_nullifier_turns > 0:
				$Panel/MarginContainer/Label.text += "Current defense: 0\n"
				$Panel/MarginContainer/Label.text += "Zero defense turns left: " + str(turns_left) + "\n"
			else:
				$Panel/MarginContainer/Label.text += "Current defense: " + str(effect_value) + "\n"
				$Panel/MarginContainer/Label.text += "Turns left: " + str(turns_left) + "\n"
	$Panel/MarginContainer/Label.text += tooltip_text

func _on_mouse_detector_mouse_entered() -> void:
	if is_enabled:
		"""
		if global_position.x > 1280/2:
			$Panel.position.x = 80
		else:
			$Panel.position.x = -4300
		"""
		$Panel.show()


func _on_mouse_detector_mouse_exited() -> void:
	$Panel.hide()
