enum TWEEN_LIMIT_MODE {
	NONE,
	CEILING,
	FLOOR,
	CLAMP,
	SOFT_CEILING,
	SOFT_FLOOR,
	SOFT_CLAMP,
	WRAP,
	YOYO,
	BOUNCE
}

/// @desc	 A value that changes every step.
/// @param {real}									 _value
/// @param {real}									 _delta
/// @param {real}									 _min_v
/// @param {real}									 _max_v
/// @param {Enum.TWEEN_LIMIT_MODE} _limit_mode
/// @param {bool}									 _stop_outside_range  If true, delta is automatically set to 0 when value goes outside the designated range
/// @param {Function}							 [_outside_range_callback]  A function that is called when value goes outside the designated range
/// @param {Array}							   [_outside_range_callback_args] Additional arguments that are passed to _outside_range_callback
function Tween(
	_value,
	_delta,
	_min_v,
	_max_v,
	_limit_mode,
	_stop_outside_range,
	_outside_range_callback,
	_outside_range_callback_args
) constructor {
	v = _value;
	d = _delta;
	min_v = _min_v;
	max_v = _max_v;
	limit_mode = _limit_mode;
	stop_outside_range = _stop_outside_range;
	outside_range_callback = _outside_range_callback;
	outside_range_callback_args = _outside_range_callback_args;

	update = method(self, function() {
		if (d != 0) {
			var _old_v = v;
			var _new_v = v + d;

			switch (limit_mode) {
				case TWEEN_LIMIT_MODE.NONE:
					v = _new_v;
					break;
					
				case TWEEN_LIMIT_MODE.CEILING:
					v = min(_new_v, max_v);
					break;
					
				case TWEEN_LIMIT_MODE.FLOOR:
					v = max(_new_v, min_v);
					break;			
					
				case TWEEN_LIMIT_MODE.CLAMP:
					v = clamp(_new_v, min_v, max_v);
					break;
					
				case TWEEN_LIMIT_MODE.SOFT_CEILING:
					v = soft_ceiling(v, d, max_v);
					break;
					
				case TWEEN_LIMIT_MODE.SOFT_FLOOR:
					v = soft_floor(v, d, min_v);
					break;			
					
				case TWEEN_LIMIT_MODE.SOFT_CLAMP:
					v = soft_clamp(v, d, min_v, max_v);
					break;
					
				case TWEEN_LIMIT_MODE.WRAP:
					v = wrap(_new_v, min_v, max_v);
					break;
					
				case TWEEN_LIMIT_MODE.YOYO:
					v = clamp(_new_v, min_v, max_v);
					if ((v == min_v) || (v == max_v)) {
						d *= -1;
					}
					break;
					
				case TWEEN_LIMIT_MODE.BOUNCE:
					v = clamp(_new_v, min_v, max_v);
					if (v == max_v) {
						d *= -1;
					} else if (v == min_v) {
						d = 0;
					}
					break;
					
				default:
					v = _new_v;
			}
			
			if (stop_outside_range && (v >= max_v || v <= min_v)) {
				stop();
				if (is_callable(outside_range_callback)) {
					outside_range_callback(self, outside_range_callback_args);
				}
			}
		}
	});
	
	ticker = time_source_create(time_source_game, 1, time_source_units_frames, update, [], -1);
	
	function start() {
		time_source_start(ticker);
	}
	
	function stop() {
		time_source_stop(ticker);
	}
	
	function destroy() {
		time_source_destroy(ticker);
	}
}