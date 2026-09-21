/// @desc  A combination of soft_ceiling and soft_floor.
/// @param {real} _value 
/// @param {real} _delta          
/// @param {real} _min            
/// @param {real} _max            
function soft_clamp(_value, _delta, _min, _max) {
	return (_value > _max && _delta > 0) || (_value < _min && _delta < 0) ? clamp(_value, _min, _max) : _value + _delta;
}