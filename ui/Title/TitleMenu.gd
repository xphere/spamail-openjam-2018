extends Control


func _on_PlayButton_pressed() -> void:
	$ButtonClick.play()
	$Tween.interpolate_property(
		$FadeScreen, 'color',
		Color(0.0, 0.0, 0.0, 0.0),
		Color(1.0, 1.0, 1.0, 1.0),
		1.0, Tween.TRANS_QUART, Tween.EASE_IN_OUT
	)
	$Tween.start()
	yield($Tween, "tween_completed")
	get_tree().change_scene("res://ui/Game/Game.tscn")


func _on_PlayButton_mouse_entered() -> void:
	$ButtonHover.play()
