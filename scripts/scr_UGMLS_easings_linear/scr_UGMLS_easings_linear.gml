/// @desc	 Linear interpolation (same as lerp()).
/// @param {real}	_start
/// @param {real}	_end
/// @param {real}	_t
easing_linear = method(undefined, function(_start, _end, _t) {
	// (e + s) * _t + s
	return lerp(_start, _end, _t);
});