extends Node

signal no_more_envelopes()
signal more_envelopes()

export var envelopeScene : PackedScene
var available_characters : String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
var available_colors : Array = [
	Color(1.0, 0.0, 0.0),
	Color(0.0, 1.0, 0.0),
	Color(0.0, 0.0, 1.0),
]

func create_random_envelope() -> Envelope:
	var envelope = envelopeScene.instance()

	var char_index = randi() % available_characters.length()
	var label = available_characters[char_index]
	envelope.set_label(label)

	var color = available_colors[randi() % available_colors.size()]
	envelope.set_color(color)

	envelope.connect("tree_exiting", self, "_on_envelope_tree_exiting", [label])
	available_characters.erase(char_index, 1)
	if available_characters.length() == 0:
		emit_signal("no_more_envelopes")

	return envelope

func _on_envelope_tree_exiting(label : String) -> void:
	available_characters = available_characters.insert(0, label)
	if available_characters.length() == 1:
		emit_signal("more_envelopes")
