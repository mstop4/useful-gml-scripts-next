/// @desc  Allows values lower than min to go above, but not values higher than min to go below.
/// @param {real} _value 
/// @param {real} _delta     
/// @param {real} _min            
function soft_floor(_value, _delta, _min) {
	return _value < _min && _delta < 0 ? max(_value, _min) : _value + _delta;
}