/// @desc  Calculates the normalized cross product of two Vector3s
/// @param {Struct.Vector3} _vec1
/// @param {Struct.Vector3} _vec2
function cross_product_3d_normalized(_vec1, _vec2) {
	var _xp = new Vector3(
		_vec1.y*_vec2.z - _vec1.z*_vec2.y,
		_vec1.z*_vec2.x - _vec1.x*_vec2.z,
		_vec1.x*_vec2.y - _vec1.y*_vec2.x
	);
	
  var _len = point_distance_3d(0, 0, 0, _xp.x, _xp.y, _xp.z);
  _xp.x /= _len;
  _xp.y /= _len;
  _xp.z /= _len;
  
	return _xp;
}