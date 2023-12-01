/// @desc	 Get the closest intersection point between a line segment and the edge of a rectangle.
/// @param {Struct.LineSegment} _line
/// @param {Struct.Rectangle}		_bounding_box
get_edge_position = method(undefined, function(_line, _bounding_box) {
	var _cur_point = -1;
	var _cur_dist;
	var _closest_dist = 1000000;
	var _closest_pos = new Vector3(-1, -1, -1);
			
	// left
	_cur_point = ray_line_intersect(_line, _bounding_box.left_edge());
				
	if (_cur_point != -1) {
		_cur_dist = point_distance(_line.a.x, _line.a.y, _cur_point.x, _cur_point.y);
		
		if (_cur_dist < _closest_dist) {
			_closest_dist = _cur_dist;
			_closest_pos.x = _cur_point.x;
			_closest_pos.y = _cur_point.y;
			_closest_pos.z = point_direction(_line.b.x, _line.b.y, _line.a.x, _line.a.y);
		}
	}
	
	// right
	_cur_point = ray_line_intersect(_line, _bounding_box.right_edge());
				
	if (_cur_point != -1) {
		_cur_dist = point_distance(_line.a.x, _line.a.y, _cur_point.x, _cur_point.y);
		
		if (_cur_dist < _closest_dist) {
			_closest_dist = _cur_dist;
			_closest_pos.x = _cur_point.x;
			_closest_pos.y = _cur_point.y;
			_closest_pos.z = point_direction(_line.b.x, _line.b.y, _line.a.x, _line.a.y);
		}
	}
	
	// top
	_cur_point = ray_line_intersect(_line, _bounding_box.top_edge());
				
	if (_cur_point != -1) {
		_cur_dist = point_distance(_line.a.x, _line.a.y, _cur_point.x, _cur_point.y);
		
		if (_cur_dist < _closest_dist) {
			_closest_dist = _cur_dist;
			_closest_pos.x = _cur_point.x;
			_closest_pos.y = _cur_point.y;
			_closest_pos.z = point_direction(_line.b.x, _line.b.y, _line.a.x, _line.a.y);
		}
	}
	
	// bottom
	_cur_point = ray_line_intersect(_line, _bounding_box.bottom_edge());
				
	if (_cur_point != -1) {
		_cur_dist = point_distance(_line.a.x, _line.a.y, _cur_point.x, _cur_point.y);
		
		if (_cur_dist < _closest_dist) {
			_closest_dist = _cur_dist;
			_closest_pos.x = _cur_point.x;
			_closest_pos.y = _cur_point.y;
			_closest_pos.z = point_direction(_line.b.x, _line.b.y, _line.a.x, _line.a.y);
		}
	}

	return _closest_pos;
});

/// @desc	   Returns which side of a line segment a point is on.
///					 0 = on the line,
///					 < 0 = below or left,
///					 > 0 = above or right.
/// @param 	 {Struct.LineSegment} _line
/// @param	 {Struct.Vector2}		 _p
/// @returns {real}
point_which_side = method(undefined, function(_line, _p) {
	return (_p.x - _line.a.x) * (_line.b.y - _line.a.y) - (_p.y - _line.a.y) * (_line.b.x - _line.a.x);
});

/// @desc	 Removes redundant points in a Path
/// @param {Asset.GMPath}   _path
/// @param {Asset.GMObject} _obstacle
prune_path = method(undefined, function(_path, _obstacle) {
	var _num_points = path_get_number(_path);

	if (_num_points == 1)
		return;

	 var _cur = new Vector2(path_get_x(_path, 0), path_get_y(_path, 0));
	 var _next = new Vector2(0, 0);

	for (var _i=1; _i<_num_points; _i++) {
		_next.x = path_get_x(_path, _i);
		_next.y = path_get_y(_path, _i); 
	
		var _collision = collision_line(_cur.x, _cur.y, _next.x, _next.y, _obstacle, false, true);
		if (_collision == noone) {
			if (_i <_num_points-1)
				path_delete_point(_path, _i);
		}
	
		else {
			_cur.x = _next.x;
			_cur.y = _next.y;
		}
	}
});

/// @desc	  Finds the intersection point between two LineSegments
/// @param  {Struct.LineSegement}	_line1
/// @param  {Struct.LineSegement}	_line2
/// @returns {Any} FIXME: should be Struct.Vector2 | real, but Feather doen't accept it for some reason
ray_line_intersect = method(undefined, function(_line1, _line2) {
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
});

/// @desc  Calculates the reflected angle of a ray.
///				 Rr = Ri - 2 * N * (Ri . N)
/// @param {real} _incident_dir
/// @param {real} _normal_dir
ray_reflect = method(undefined, function(_incident_dir, _normal_dir) {
	var _ri = new Vector2(lengthdir_x(1, _incident_dir), lengthdir_y(1, _incident_dir));
	var _n = new Vector2(lengthdir_x(1, _normal_dir), lengthdir_y(1, _normal_dir));

	var _dot = dot_product(_ri.x, _ri.y, _n.x, _n.y);
	var _reflect_x = _ri.x - 2 * _n.x * _dot;
	var _reflect_y = _ri.y - 2 * _n.y * _dot;

	return point_direction(0, 0, _reflect_x, _reflect_y);
});