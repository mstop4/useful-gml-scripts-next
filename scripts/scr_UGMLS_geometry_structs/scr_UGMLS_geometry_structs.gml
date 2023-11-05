/// @param {real} _ax
/// @param {real} _ay
/// @param {real} _bx
/// @param {real} _by
function LineSegment(_ax, _ay, _bx, _by) constructor {
	a = new Vector2(_ax, _ay);
	b = new Vector2(_bx, _by);
}

/// @param {real} _left
/// @param {real} _top
/// @param {real} _right
/// @param {real} _bottom
function Rectangle(_left, _top, _right, _bottom) constructor {
	left = _left;
	top = _top;
	right = _right;
	bottom = _bottom;
	
	function width() {
		return self.right - self.left;
	}
	
	function height() {
		return self.bottom - self.top;
	}
	
	function left_edge() {
		return new LineSegment(self.left, self.top, self.left, self.bottom);
	}
	
	function top_edge() {
		return new LineSegment(self.left, self.top, self.right, self.top);
	}
	
	function right_edge() {
		return new LineSegment(self.right, self.top, self.right, self.bottom);
	}
	
	function bottom_edge() {
		return new LineSegment(self.left, self.bottom, self.right, self.bottom);
	}
	// Feather restore GM1041
}