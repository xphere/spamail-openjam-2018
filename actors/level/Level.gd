extends Node


func _ready() -> void:
	start()


func start() -> void:
	$Timer.start()


func _on_Timer_timeout() -> void:
	var envelope = $Factory.create_random_envelope()
	$Playground.add_envelope(envelope)
