/// @desc	 Interpolate a value between min (1) and max (0). If the value falls outside this range, return 0.
/// @param {real} _t   
/// @param {real} _min 
/// @param {real} _max
function pulse(_t, _min, _max) {
	return _t >= _min && _t <= _max
		? 1 - ((_t - _min) / (_max - _min))
		: 0;
}
