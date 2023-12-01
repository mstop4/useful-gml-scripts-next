/// @desc  Quadratic interpolation in.
/// @param {real}	_start
/// @param {real}	_end
/// @param {real}	_t
easing_quadratic_in = method(undefined, function(_start, _end, _t) {
	// (e + s) * _t^2 + s
	var _t2 = clamp(power(_t, 2), 0, 1);
	return lerp(_start, _end, _t2);
});

/// @desc  Quadratic interpolation in.
/// @param {real}	_start
/// @param {real}	_end
/// @param {real}	_t
easing_quadratic_out = method(undefined, function(_start, _end, _t) {
	// (e + s) * 1 - (1-t)^2 + s
	var _t2 = clamp(1 - power(1-_t, 2), 0, 1);
	return lerp(_start, _end, _t2);
});

/// @desc  Quadratic interpolation in/out.
/// @param {real}	_start
/// @param {real}	_end
/// @param {real}	_t
easing_quadratic_inout = method(undefined, function(_start, _end, _t) {
	// 0 - 0.5: (e + s) * (2 * t^2) + s
	// 0.5 - 1: (e + s) * (-2 * (1-t)^2 + 1) + sW
	var _t2 = _t < 0.5
		? clamp(2 * power(_t, 2), 0, 1)
		: clamp(-2 * power(1 - _t, 2) + 1, 0, 1); 
	
	return lerp(_start, _end, _t2);
});