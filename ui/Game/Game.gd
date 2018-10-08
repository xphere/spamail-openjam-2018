extends Control

export var level_scene : PackedScene


func _ready() -> void:
	assert level_scene

	var level = level_scene.instance()
	level.pause_mode = PAUSE_MODE_STOP
	add_child(level)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if $PauseMenu.visible:
			$PauseMenu.hide()
			return

		get_tree().paused = true
		$PauseMenu.popup()
		yield($PauseMenu, "popup_hide")
		get_tree().paused = false


func _on_backtoplay_pressed() -> void:
	$ButtonClick.play()
	yield($ButtonClick, "finished")
	$PauseMenu.hide()


func _on_backtomenu_pressed() -> void:
	$ButtonClick.play()
	yield($ButtonClick, "finished")
	$PauseMenu.hide()
	get_tree().change_scene("res://ui/Title/TitleMenu.tscn")


func _on_button_entered() -> void:
	$ButtonHover.play()
