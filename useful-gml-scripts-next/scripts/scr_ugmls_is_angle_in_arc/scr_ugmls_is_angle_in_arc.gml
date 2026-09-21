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