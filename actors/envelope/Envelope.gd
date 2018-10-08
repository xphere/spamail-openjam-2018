extends PhysicsBody2D

class_name Envelope

signal sent()

enum {
	STATE_INCOMING,
	STATE_INGAME,
	STATE_SENT,
}

var label
var category
var state
var tainted = false


func set_label(label: String) -> void:
	$Pivot/Letter/Label.text = label
	self.label = label


func has_label(label: String) -> bool:
	return self.label == label


func incoming() -> void:
	assert state == null
	state = STATE_INCOMING


func ingame() -> void:
	assert state == STATE_INCOMING
	state = STATE_INGAME

	set_collision_layer_bit(0, true)
	set_collision_layer_bit(1, false)
	set_collision_mask_bit(0, true)
	set_collision_mask_bit(2, false)


func is_ingame() -> bool:
	return state == STATE_INGAME


func send() -> void:
	assert state == STATE_INGAME
	state = STATE_SENT

	set_collision_layer_bit(3, true)
	set_collision_layer_bit(0, false)
	set_collision_mask_bit(4, true)
	set_collision_mask_bit(0, false)

	emit_signal("sent")


func taint() -> void:
	tainted = true


func kill() -> void:
	queue_free()


func set_category(category) -> void:
	var color = category.color

	self.category = category

	$Pivot/Back.modulate = color
	$Pivot/Opened.modulate = color
	$Pivot/Closed.modulate = color
	$Pivot/Front.modulate = color
