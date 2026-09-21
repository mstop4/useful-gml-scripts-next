/// @desc  A 2D vector (x, y)
/// @param {real} _x
/// @param {real} _y
function Vector2(_x, _y) constructor {
	x = _x;
	y = _y;
	
	function to_string() {
		return $"[ {x}, {y} ]";
	}
	
	/// @desc    Adds this vector to another Vector2
	/// @param   {Struct.Vector2} _vec2
	/// @returns {Struct.Vector2}
	function add(_vec2) {
		return new Vector2(x + _vec2.x, y + _vec2.y);
	}
	
	/// @desc    Subtracts another Vector2 from this vector
	/// @param   {Struct.Vector2} _vec2
	/// @returns {Struct.Vector2}
	function subtract(_vec2) {
		return new Vector2(x - _vec2.x, y - _vec2.y);
	}
}