/// @desc	Returns a normalized copy of a Vector3.
/// @param {Struct.Vector3} _vec 
function normalize_3d(_vec) {
	var _len = point_distance_3d(0, 0, 0, _vec.x, _vec.y, _vec.z);
	return new Vector3(_vec.x / _len, _vec.y / _len, _vec.z / _len);
}