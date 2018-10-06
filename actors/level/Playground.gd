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


func _on_GameArea_body_entered(body: PhysicsBody2D) -> void:
	body.set_collision_layer_bit(0, true)
	body.set_collision_layer_bit(1, false)
	body.set_collision_mask_bit(0, true)
	body.set_collision_mask_bit(2, false)
