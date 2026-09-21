/// @desc  Returns the normalized value of an angle (between 0 and 359 degrees)
/// @param {real} _angle
function normalize_angle(_angle) {
	while (_angle < 0) _angle += 360;
	while (_angle > 360) _angle -= 360;
	return _angle;
}