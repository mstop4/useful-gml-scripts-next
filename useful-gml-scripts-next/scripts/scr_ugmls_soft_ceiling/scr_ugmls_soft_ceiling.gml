/// @desc  Allows values higher than max to go below, but not values lower than max to go above.
/// @param {real} _value 
/// @param {real} _delta     
/// @param {real} _max            
function soft_ceiling(_value, _delta, _max) {
	return _value > _max && _delta > 0 ? min(_value, _max) : _value + _delta;
}