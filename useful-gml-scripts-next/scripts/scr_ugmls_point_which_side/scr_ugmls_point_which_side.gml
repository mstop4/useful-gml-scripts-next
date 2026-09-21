/// @desc	   Returns which side of a line segment a point is on.
///					 0 = on the line,
///					 < 0 = below or left,
///					 > 0 = above or right.
/// @param 	 {Struct.LineSegment} _line
/// @param	 {Struct.Vector2}		 _p
/// @returns {real}
function point_which_side(_line, _p) {
	return (_p.x - _line.a.x) * (_line.b.y - _line.a.y) - (_p.y - _line.a.y) * (_line.b.x - _line.a.x);
}