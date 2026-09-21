/// @desc  A line segment defined by two points "a" and "b"
/// @param {real} _ax
/// @param {real} _ay
/// @param {real} _bx
/// @param {real} _by
function LineSegment(_ax, _ay, _bx, _by) constructor {
	a = new Vector2(_ax, _ay);
	b = new Vector2(_bx, _by);
}