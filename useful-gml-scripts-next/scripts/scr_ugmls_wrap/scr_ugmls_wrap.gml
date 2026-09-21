/// @desc  Wraps a value to a number between min and max (where min < max)
/// @param {real} _value 
/// @param {real} _min   
/// @param {real} _max   
function wrap(_value, _min, _max) {
	var _range = _max - _min + 1;
	if (_range <= 0) return 0;

	var _a = floor((_value - _min) / _range);
	return _value - _a * _range;
}