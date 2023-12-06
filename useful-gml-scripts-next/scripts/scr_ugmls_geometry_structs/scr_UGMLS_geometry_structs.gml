/// @desc  A line segment defined by two points "a" and "b"
/// @param {real} _ax
/// @param {real} _ay
/// @param {real} _bx
/// @param {real} _by
function LineSegment(_ax, _ay, _bx, _by) constructor {
	a = new Vector2(_ax, _ay);
	b = new Vector2(_bx, _by);
}

/// @desc  A rectangle defined by four sides: "top", "left", "bottom", and "right"
/// @param {real} _left
/// @param {real} _top
/// @param {real} _right
/// @param {real} _bottom
function Rectangle(_left, _top, _right, _bottom) constructor {
	left = _left;
	top = _top;
	right = _right;
	bottom = _bottom;
	
	/// @desc Width of rectangle
	function width() {
		return right - left;
	}
	
	/// @desc Height of rectangle
	function height () {
		return bottom - top;
	}
	
	/// @desc A LineSegment representing the left-side edge
	function left_edge() {
		return new LineSegment(left, top, left, bottom);
	}
	
	/// @desc A LineSegment representing the top edge
	function top_edge() {
		return new LineSegment(left, top, right, top);
	}
	
	/// @desc A LineSegment representing the right-side edge
	function right_edge() {
		return new LineSegment(right, top, right, bottom);
	}
	
	/// @desc A LineSegment representing the bottom edge
	function bottom_edge() {
		return new LineSegment(left, bottom, right, bottom);
	}
}