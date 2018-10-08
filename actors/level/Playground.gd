extends Node

signal sent_envelope(envelope)

onready var dimensions : Vector2 = $Corner.position
var current_category


func add_envelope(envelope: Envelope) -> void:
	var center = dimensions / 2.0
	var angle = randf() * 2.0 * PI
	var spawning_vector = Vector2(0.0, 600.0).rotated(angle)
	var spawning_position = center + spawning_vector

	envelope.position = spawning_position
	envelope.apply_central_impulse(-spawning_vector)
	envelope.incoming()

	add_child(envelope)


func remove_envelope_by_label(label: String) -> void:
	for envelope in get_children():
		if not envelope is Envelope:
			continue

		if not envelope.has_label(label) or not envelope.is_ingame():
			continue

		if envelope.category != current_category:
			envelope.taint()

		envelope.send()
		emit_signal("sent_envelope", envelope)


func set_current_category(category):
	current_category = category


func _on_GameArea_body_entered(body) -> void:
	if not body is Envelope:
		return

	body.ingame()
