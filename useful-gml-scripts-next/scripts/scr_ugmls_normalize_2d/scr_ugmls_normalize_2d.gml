/// @desc	 Returns a normalized copy of a Vector2.
/// @param {Struct.Vector2} _vec
function normalize_2d(_vec) {
	var _len = point_distance(0, 0, _vec.x, _vec.y);
	return new Vector2(_vec.x / _len, _vec.y / _len);
}