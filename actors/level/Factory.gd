extends Node

signal no_more_envelopes()
signal more_envelopes()

export var envelopeScene : PackedScene
var available_characters : String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

func create_random_envelope() -> Envelope:
	var envelope = envelopeScene.instance()
	var char_index = randi() % available_characters.length()
	var label = available_characters[char_index]
	
	envelope.set_label(label)
	envelope.connect("tree_exiting",self,"_on_envelope_tree_exiting",[label])
	available_characters.erase(char_index, 1)
	if available_characters.length() == 0:
		emit_signal("no_more_envelopes")

	return envelope
	
func _on_envelope_tree_exiting(label : String) -> void:
	available_characters = available_characters.insert(0,label)
	if available_characters.length() == 1:
		emit_signal("more_envelopes")
