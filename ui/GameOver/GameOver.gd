extends Node


func _ready():
	for child in get_children():
		if not child is Envelope:
			continue
		child.set_envelope_color(Color(randf(), randf(), randf()))
		child.rotation_degrees = randf() * 90 - 45
		child.set_label(child.name)
