extends Node

var category_by_scancode = {}


func _ready() -> void:
	var categories = $Sidebar.get_categories()

	var current_scancode = KEY_F1
	for category in categories:
		category_by_scancode[current_scancode] = category
		current_scancode += 1

	$Factory.set_available_categories(categories)
	_set_current_category(categories[0])

	start()


func _input(event : InputEvent) -> void:
	if not event is InputEventKey or event.is_echo() or not event.is_pressed():
		return

	var pressed_key = OS.get_scancode_string(event.scancode)
	if pressed_key.length() == 1:
		$Playground.remove_envelope_by_label(pressed_key)
		return

	if event.scancode in category_by_scancode.keys():
		_set_current_category(category_by_scancode[event.scancode])


func start() -> void:
	$Timer.start()


func _set_current_category(category) -> void:
	$Sidebar.set_current_category(category.name)
	$Playground.set_current_category(category)


func _on_Timer_timeout() -> void:
	var envelope = $Factory.create_random_envelope()
	$Playground.add_envelope(envelope)


func _on_Factory_no_more_envelopes():
	$Timer.stop()


func _on_Factory_more_envelopes():
	$Timer.start()


func _on_Playground_sent_envelope(envelope: Envelope) -> void:
	var impulse = $Sidebar.current_category.rect_global_position - envelope.global_position
	envelope.linear_velocity = Vector2()
	envelope.apply_central_impulse(impulse)


func _on_Sidebar_wrong_category() -> void:
	$Inbox.add_message("Whatever")


func _on_Inbox_overflow() -> void:
	get_tree().paused = true
