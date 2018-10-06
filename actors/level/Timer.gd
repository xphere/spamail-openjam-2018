extends Timer

export var curve : Curve
export var length : int = 100
var current_time : int = 0


func _ready() -> void:
	curve.bake_resolution = length
	curve.bake()
	_update_timeout()


func _on_Timer_timeout():
	current_time = min(current_time + 1, length)
	_update_timeout()


func _update_timeout() -> void :
	set_wait_time(curve.interpolate_baked(current_time * 1.0 / length))
