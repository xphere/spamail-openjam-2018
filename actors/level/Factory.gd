extends Node

signal no_more_envelopes()

export var envelopeScene : PackedScene
var available_characters : String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

func create_random_envelope() -> Envelope:
	var envelope = envelopeScene.instance()
	var chosen_character = randi() % available_characters.length()
	envelope.set_label(available_characters[chosen_character])
	available_characters.erase(chosen_character, 1)
	if available_characters.length() == 0:
		emit_signal("no_more_envelopes")
	return envelope
