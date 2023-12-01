/// @desc	 Quartic interpolation in.
/// @param {real}	_start
/// @param {real}	_end
/// @param {real}	_t
easing_quartic_in = method(undefined, function(_start, _end, _t) {
	// (e + s) * t^4 + s
	var _t2 = clamp(power(_t, 4), 0, 1);
	return lerp(_start, _end, _t2);
});

/// @desc	 Quartic interpolation out.
/// @param {real}	_start
/// @param {real}	_end
/// @param {real}	_t
easing_quartic_out = method(undefined, function(_start, _end, _t) {
	// (e + s) * 1 - (1-t)^4 + s
	var _t2 = clamp(1 - power(1-_t, 4), 0, 1);
	return lerp(_start, _end, _t2);
});

/// @desc  Quartic interpolation in/out.
/// @param {real}	_start
/// @param {real}	_end
/// @param {real}	_t
easing_quartic_inout = method(undefined, function(_start, _end, _t) {
	// 0 - 0.5: (e + s) * (8 * t^4) + s
	// 0.5 - 1: (e + s) * (-8 * (1 - t)^4 + 1) + s
	var _t2 = _t < 0.5
		? clamp(8 * power(_t, 4), 0, 1)
		: clamp(-8 * power(1 - _t, 4) + 1, 0, 1); 
	
	return lerp(_start, _end, _t2);
});