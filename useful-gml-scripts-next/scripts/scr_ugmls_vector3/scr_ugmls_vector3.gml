/// @desc  A 3D vector (x, y, z)
/// @param {real} _x
/// @param {real} _y
/// @param {real} _z
function Vector3(_x, _y, _z) constructor {
	x = _x;
	y = _y;
	z = _z;
	
	function to_string() {
		return $"[ {x}, {y}, {z} ]";
	}
	
	/// @desc    Adds this vector to another Vector3
	/// @param   {Struct.Vector3} _vec3
	/// @returns {Struct.Vector3}
	function add(_vec3) {
		return new Vector3(x + _vec3.x, y + _vec3.y, z + _vec3.z);
	}
	
	/// @desc    Subtracts another Vector3 from this vector
	/// @param   {Struct.Vector3} _vec3
	/// @returns {Struct.Vector3}
	function subtract (_vec3) {
		return new Vector3(x - _vec3.x, y - _vec3.y, z - _vec3.z);
	}
}