/// @desc  Creates an array containing numbers from _a to _b (inclusive by default), each _step units apart
/// @param {Real} _a
/// @param {Real} _b
/// @param {Real} _step
/// @param {Bool} [_include_b]
/// @param {Bool} [_shuffle]
function create_numeric_sequence_array(_a, _b, _step, _include_b = true, _shuffle = false) {
	var _arr = [];
	var _signed_step = abs(_step) * sign(_b - _a);
	for (var _i=_a; _i<_b; _i+=_signed_step) {
		array_push(_arr, _i);
	}
	
	if (_include_b) {
		array_push(_arr, _b);
	}
	
	return _shuffle ? array_shuffle(_arr) : _arr;
}