extends Node2D

class_name Envelope

var label


func set_label(label : String) -> void:
	$Letter/Label.text = label
	self.label = label

func kill() -> void:
	queue_free()
