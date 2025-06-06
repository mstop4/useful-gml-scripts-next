/// @desc	 Returns a normalized copy of a Vector2.
/// @param {Struct.Vector2} _vec
function normalize_2d(_vec) {
	var _len = point_distance(0, 0, _vec.x, _vec.y);
	return new Vector2(_vec.x / _len, _vec.y / _len);
}

/// @desc	Returns a normalized copy of a Vector3.
/// @param {Struct.Vector3} _vec 
function normalize_3d(_vec) {
	var _len = point_distance_3d(0, 0, 0, _vec.x, _vec.y, _vec.z);
	return new Vector3(_vec.x / _len, _vec.y / _len, _vec.z / _len);
}

/// @desc	 Calculates cross product of two Vector3s.
/// @param {Struct.Vector3} _vec1
/// @param {Struct.Vector3} _vec2
function cross_product(_vec1, _vec2) {
	return new Vector3(
		_vec1.y*_vec2.z - _vec1.z*_vec2.y,
		_vec1.z*_vec2.x - _vec1.x*_vec2.z,
		_vec1.x*_vec2.y - _vec1.y*_vec2.x
	);
}

/// @desc	   Calculates the z-component of the "cross product" of two Vector2s.
/// @param   {Struct.Vector2} _vec1
/// @param   {Struct.Vector2} _vec2
/// @returns {real}
function cross_product_2d(_vec1, _vec2) {
	return _vec1.x*_vec2.y - _vec1.y*_vec2.x;
}

/// @desc  Calculates the normalized cross product of two Vector3s
/// @param {Struct.Vector3} _vec1
/// @param {Struct.Vector3} _vec2
function cross_product_normalized(_vec1, _vec2) {
	var _xp = new Vector3(
		_vec1.y*_vec2.z - _vec1.z*_vec2.y,
		_vec1.z*_vec2.x - _vec1.x*_vec2.z,
		_vec1.x*_vec2.y - _vec1.y*_vec2.x
	);
	
	return normalize_3d(_xp);
}

/// @desc  Returns the normalized value of an angle (between 0 and 359 degrees)
/// @param {real} _angle
function normalize_angle(_angle) {
	while (_angle < 0) _angle += 360;
	while (_angle > 360) _angle -= 360;
	return _angle;
}

/// @desc Check if angle value is inside given arc
/// @param {real} _angle
/// @param {real} _arc_start
/// @param {real} _arc_end
function is_angle_in_arc(_angle, _arc_start, _arc_end) {
	// Normalize values
	var _angle_n = normalize_angle(_angle);
	var _arc_start_n = normalize_angle(_arc_start);
	var _arc_end_n = normalize_angle(_arc_end);
	
	if (_arc_start_n <= _arc_end_n) return (_angle_n >= _arc_start_n) && (_angle_n <= _arc_end_n);
	else return (_angle_n >= _arc_start_n) || (_angle_n <= _arc_end_n);
}

/// @desc	 Interpolate a value between min (1) and max (0). If the value falls outside this range, return 0.
/// @param {real} _t   
/// @param {real} _min 
/// @param {real} _max
function pulse(_t, _min, _max) {
	return _t >= _min && _t <= _max
		? 1 - ((_t - _min) / (_max - _min))
		: 0;
}

/// @desc	 Bilinear interpolation
/// @param {real} _a
/// @param {real} _b
/// @param {real} _c
/// @param {real} _d 
/// @param {real} _w1
/// @param {real} _w2
function blin(_a, _b, _c, _d, _w1, _w2) {
	var _ab = lerp(_a, _b, _w1);
	var _cd = lerp(_c, _d, _w1);
	return lerp(_ab, _cd, _w2);
}

/// @desc  Allows values higher than max to go below, but not values lower than max to go above.
/// @param {real} _value 
/// @param {real} _delta     
/// @param {real} _max            
function soft_ceiling(_value, _delta, _max) {
	return _value > _max && _delta > 0 ? min(_value, _max) : _value + _delta;
}

/// @desc  Allows values lower than min to go above, but not values higher than min to go below.
/// @param {real} _value 
/// @param {real} _delta     
/// @param {real} _min            
function soft_floor(_value, _delta, _min) {
	return _value < _min && _delta < 0 ? max(_value, _min) : _value + _delta;
}

/// @desc  A combination of soft_ceiling and soft_floor.
/// @param {real} _value 
/// @param {real} _delta          
/// @param {real} _min            
/// @param {real} _max            
function soft_clamp(_value, _delta, _min, _max) {
	return (_value > _max && _delta > 0) || (_value < _min && _delta < 0) ? clamp(_value, _min, _max) : _value + _delta;
}

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