/// @desc	 Get the closest intersection point between a line segment and the edge of a rectangle.
///        x, y: the coordinates of the intersection point
///        angle: the angle to the intersection point
///        z: same as dir, for backward compatibility
///        side: which side of the bounding box the intersection point is on:
///        0 - left, 1 - top, 2 - right, 3 - bottom
/// @param {Struct.LineSegment} _line
/// @param {Struct.Rectangle}		_bounding_box
function get_edge_position(_line, _bounding_box) {
	var _cur_point = -1;
	var _cur_dist;
	var _closest_dist = 1000000;
	var _closest_pos = {
		x: -1,
		y: -1,
		z: -1,
		angle: -1,
		side: -1
	};
			
	// left
	_cur_point = ray_line_intersect(_line, _bounding_box.left_edge());
				
	if (_cur_point != -1) {
		_cur_dist = point_distance(_line.a.x, _line.a.y, _cur_point.x, _cur_point.y);
		
		if (_cur_dist < _closest_dist) {
			_closest_dist = _cur_dist;
			_closest_pos.x = _cur_point.x;
			_closest_pos.y = _cur_point.y;
			_closest_pos.z = point_direction(_line.b.x, _line.b.y, _line.a.x, _line.a.y);
			_closest_pos.angle = _closest_pos.z;
			_closest_pos.side = 0;
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
			_closest_pos.angle = _closest_pos.z;
			_closest_pos.side = 2;
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
			_closest_pos.angle = _closest_pos.z;
			_closest_pos.side = 1;
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
			_closest_pos.angle = _closest_pos.z;
			_closest_pos.side = 3;
		}
	}

	return _closest_pos;
}

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

/// @desc	 Removes redundant points in a Path
/// @param {Asset.GMPath}   _path
/// @param {Asset.GMObject|Id.TileMapElement} _obstacle
function prune_path(_path, _obstacle) {
	var _num_points = path_get_number(_path);
	var _remove_list = [];

	if (_num_points == 1)
		return;

	 var _cur = new Vector2(path_get_x(_path, _num_points-1), path_get_y(_path, _num_points-1));
	 var _next = new Vector2(0, 0);

	for (var _i=_num_points-2; _i>0; _i--) {
		_next.x = path_get_x(_path, _i);
		_next.y = path_get_y(_path, _i); 
	
		var _collision = collision_line(_cur.x, _cur.y, _next.x, _next.y, _obstacle, false, true);
		if (_collision == noone) {
			path_delete_point(_path, _i);
			_i--;
		}
	
		else {
			_cur.x = _next.x;
			_cur.y = _next.y;
		}
	}
}

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

/// @desc  Calculates the reflected angle of a ray.
///				 Rr = Ri - 2 * N * (Ri . N)
/// @param {real} _incident_dir
/// @param {real} _normal_dir
function ray_reflect(_incident_dir, _normal_dir) {
	var _ri = new Vector2(lengthdir_x(1, _incident_dir), lengthdir_y(1, _incident_dir));
	var _n = new Vector2(lengthdir_x(1, _normal_dir), lengthdir_y(1, _normal_dir));

	var _dot = dot_product(_ri.x, _ri.y, _n.x, _n.y);
	var _reflect_x = _ri.x - 2 * _n.x * _dot;
	var _reflect_y = _ri.y - 2 * _n.y * _dot;

	return point_direction(0, 0, _reflect_x, _reflect_y);
}