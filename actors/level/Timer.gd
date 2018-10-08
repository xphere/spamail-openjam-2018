extends Timer

export var curve : Curve
export var length : int = 100
var current_time : int = 0


func _ready() -> void:
	curve.bake_resolution = length


func _on_Timer_timeout():
	current_time = min(current_time + 1, length)
	_update_timeout()


func _update_timeout() -> void :
	var next_timeout = curve.interpolate_baked(current_time * 1.0 / length)
	set_wait_time(next_timeout)
