extends Node

signal no_more_envelopes()
signal more_envelopes()

export var envelope_scene : PackedScene
export var spam_category : NodePath
var available_characters : String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
var available_categories : Array


func set_available_categories(categories):
	available_categories = categories


func create_random_envelope() -> Envelope:
	var envelope = envelope_scene.instance()

	var char_index = randi() % available_characters.length()
	var label = available_characters[char_index]
	envelope.set_label(label)

	var category = available_categories[randi() % available_categories.size()]
	envelope.set_category(category)

	if get_node(spam_category) == category:
		envelope.set_timed()

	envelope.connect("sent", self, "_on_envelope_sent", [label])
	available_characters.erase(char_index, 1)
	if available_characters.length() == 0:
		emit_signal("no_more_envelopes")

	return envelope

func _on_envelope_sent(label : String) -> void:
	available_characters = available_characters.insert(0, label)
	if available_characters.length() == 1:
		emit_signal("more_envelopes")
