extends Node

func _ready() -> void:
	start()


func _input(event : InputEvent) -> void:
	if not event is InputEventKey or event.is_echo() or not event.is_pressed():
		return
	var pressed_key = OS.get_scancode_string(event.scancode)
	if pressed_key.length() == 1:
		$Playground.remove_envelope_by_label(pressed_key)


func start() -> void:
	$Timer.start()


func _on_Timer_timeout() -> void:
	var envelope = $Factory.create_random_envelope()
	$Playground.add_envelope(envelope)


func _on_Factory_no_more_envelopes():
	$Timer.stop()


func _on_Factory_more_envelopes():
	$Timer.start()
