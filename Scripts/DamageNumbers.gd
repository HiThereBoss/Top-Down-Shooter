extends Node

func display_number(value: float, position: Vector2, is_critical: bool = false):
	var number = Label.new()
	number.global_position = Vector2(position.x + randf_range(-5, 5), position.y + randf_range(-2, -4))
	number.text = str(value)
	number.z_index = 5
	number.label_settings = LabelSettings.new()
	
	var color = "#FFF" if !is_critical else "#B22"
	
	if value == 0:
		color = "FFF8"
	
	number.label_settings.font_color = color
	number.label_settings.font_size = 6
	number.label_settings.outline_color = "#000"
	number.label_settings.outline_size = 1
	
	call_deferred("add_child", number)
	
	await number.resized
	number.pivot_offset = Vector2(number.size / 2)
	
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(
		number, "position:y", number.position.y - 24, 0.25
	).set_ease(Tween.EASE_OUT)
	tween.tween_property(
		number, "scale", Vector2.ZERO, 0.25
	).set_ease(Tween.EASE_IN).set_delay(0.25)
	
	await tween.finished
	number.queue_free()
