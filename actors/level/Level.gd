extends Node

var category_by_scancode = {}


func _ready() -> void:
	var categories = $Sidebar.get_categories()

	var current_scancode = KEY_F1
	for category in categories:
		category_by_scancode[current_scancode] = category.name
		current_scancode += 1

	$Factory.set_available_categories(categories)
	$Sidebar.set_current_category(categories[0].name)

	start()


func _input(event : InputEvent) -> void:
	if not event is InputEventKey or event.is_echo() or not event.is_pressed():
		return

	var pressed_key = OS.get_scancode_string(event.scancode)
	if pressed_key.length() == 1:
		$Playground.remove_envelope_by_label(pressed_key)
		return

	if event.scancode in category_by_scancode.keys():
		$Sidebar.set_current_category(category_by_scancode[event.scancode])


func start() -> void:
	$Timer.start()


func _on_Timer_timeout() -> void:
	var envelope = $Factory.create_random_envelope()
	$Playground.add_envelope(envelope)


func _on_Factory_no_more_envelopes():
	$Timer.stop()


func _on_Factory_more_envelopes():
	$Timer.start()
