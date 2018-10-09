extends Node


func set_highscore(highscore: int) -> void:
	if not has_node("HighScore"):
		call_deferred("set_highscore", highscore)
	else:
		$HighScore.text += "%d" % highscore


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://ui/Title/TitleMenu.tscn")


func _ready():
	for child in get_children():
		if not child is Envelope:
			continue
		child.set_envelope_color(Color(randf(), randf(), randf()))
		child.rotation_degrees = randf() * 90 - 45
		child.set_label(child.name)
