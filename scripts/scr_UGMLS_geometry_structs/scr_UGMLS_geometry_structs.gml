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
	
	/// @desc Width of rectangle
	width = method(self, function() {
		return self.right - self.left;
	});
	
	/// @desc Height of rectangle
	height = method(self, function() {
		return self.bottom - self.top;
	});
	
	/// @desc A LineSegment representing the left-side edge
	left_edge = method(self, function() {
		return new LineSegment(self.left, self.top, self.left, self.bottom);
	});
	
	/// @desc A LineSegment representing the top edge
	top_edge = method(self, function() {
		return new LineSegment(self.left, self.top, self.right, self.top);
	});
	
	/// @desc A LineSegment representing the right-side edge
	right_edge = method(self, function() {
		return new LineSegment(self.right, self.top, self.right, self.bottom);
	});
	
	/// @desc A LineSegment representing the bottom edge
	bottom_edge = method(self, function() {
		return new LineSegment(self.left, self.bottom, self.right, self.bottom);
	});
}