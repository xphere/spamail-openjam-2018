extends Node

onready var dimensions : Vector2 = $Corner.position


func add_envelope(envelope: Envelope) -> void:
	envelope.position = Vector2(
		randf() * dimensions.x,
		randf() * dimensions.y
	)
	add_child(envelope)


func remove_envelope_by_label(label: String) -> void:
	for child in get_children():
		if child is Envelope and child.label == label:
			child.kill()
