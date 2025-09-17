/// @desc  A line segment defined by two points "a" and "b"
/// @param {real} _ax
/// @param {real} _ay
/// @param {real} _bx
/// @param {real} _by
function LineSegment(_ax, _ay, _bx, _by) constructor {
	a = new Vector2(_ax, _ay);
	b = new Vector2(_bx, _by);
}

/// @desc  A 3D ray defined by origin "o" and direction "d"
/// @param {real} _ox
/// @param {real} _oy
/// @param {real} _oz
/// @param {real} _dx
/// @param {real} _dy
/// @param {real} _dz
function Ray3D(_ox, _oy, _oz, _dx, _dy, _dz) constructor {
  o = new Vector3(_ox, _oy, _oz);
  d = new Vector3(_dx, _dy, _dz);
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
	function height() {
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

/// @desc  A sphere defined by center "c" and radius "r"
/// @param {real} _cx
/// @param {real} _cy
/// @param {real} _cz
/// @param {real} _radius
function Sphere(_cx, _cy, _cz, _radius) constructor {
  c = new Vector3(_cx, _cy, _cz);
  r = _radius;
}

/// @desc  A box defined by 2 corner points
/// @param {real} _ax
/// @param {real} _ay
/// @param {real} _az
/// @param {real} _bx
/// @param {real} _by
/// @param {real} _bz
function Box(_ax, _ay, _az, _bx, _by, _bz) constructor {
  min_corner = new Vector3(min(_ax, _bx), min(_ay, _by), min(_az, _bz));
  max_corner = new Vector3(max(_ax, _bx), max(_ay, _by), max(_az, _bz));
}