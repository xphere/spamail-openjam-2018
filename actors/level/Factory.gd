extends Node

export var envelopeScene : PackedScene


func create_random_envelope() -> Envelope:
	var envelope = envelopeScene.instance()

	return envelope
