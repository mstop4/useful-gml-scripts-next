/// @desc	   Calculates the z-component of the "cross product" of two Vector2s.
/// @param   {Struct.Vector2} _vec1
/// @param   {Struct.Vector2} _vec2
/// @returns {real}
function cross_product_2d(_vec1, _vec2) {
	return _vec1.x*_vec2.y - _vec1.y*_vec2.x;
}