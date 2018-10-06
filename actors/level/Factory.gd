extends Node

export var envelopeScene : PackedScene
var available_characters : String = "ABCDE"

func create_random_envelope() -> Envelope:
	var envelope = envelopeScene.instance()
	var chosen_character = randi() % available_characters.length()
	envelope.set_label(available_characters[chosen_character])
	return envelope
