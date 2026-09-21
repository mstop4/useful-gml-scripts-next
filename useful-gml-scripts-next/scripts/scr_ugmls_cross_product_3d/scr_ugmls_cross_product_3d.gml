/// @desc	 Calculates cross product of two Vector3s.
/// @param {Struct.Vector3} _vec1
/// @param {Struct.Vector3} _vec2
function cross_product_3d(_vec1, _vec2) {
	return new Vector3(
		_vec1.y*_vec2.z - _vec1.z*_vec2.y,
		_vec1.z*_vec2.x - _vec1.x*_vec2.z,
		_vec1.x*_vec2.y - _vec1.y*_vec2.x
	);
}