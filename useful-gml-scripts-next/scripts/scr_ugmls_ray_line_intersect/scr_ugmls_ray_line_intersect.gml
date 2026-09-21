/// @desc	  Finds the intersection point between two LineSegments
/// @param  {Struct.LineSegement}	_line1
/// @param  {Struct.LineSegement}	_line2
/// @returns {Any} FIXME: should be Struct.Vector2 | real, but Feather doen't accept it for some reason
function ray_line_intersect(_line1, _line2) {
	var _ray_dir = point_direction(_line1.a.x, _line1.a.y, _line1.b.x, _line1.b.y);

	var _v1 = new Vector2(_line1.a.x - _line2.a.x, _line1.a.y - _line2.a.y);
	var _v2 = new Vector2(_line2.b.x - _line2.a.x, _line2.b.y - _line2.a.y);
	var _v3 = new Vector2(-lengthdir_y(1, _ray_dir), lengthdir_x(1, _ray_dir));

	var _dot = dot_product(_v2.x, _v2.y, _v3.x, _v3.y);

	if (abs(_dot) == 0)
		return -1;
	
	var _t1 = cross_product_2d(_v2, _v1) / _dot;
	var _t2 = dot_product(_v1.x, _v1.y, _v3.x, _v3.y) / _dot;

	if (_t1 >= 0 && (_t2 >= 0 && _t2 <= 1)) {
		var _unit_ray = new Vector2(lengthdir_x(1, _ray_dir), lengthdir_y(1, _ray_dir));
		return new Vector2(_line1.a.x + _unit_ray.x * _t1, _line1.a.y + _unit_ray.y * _t1);
	}

	return -1;
}