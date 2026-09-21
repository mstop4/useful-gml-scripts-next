/// @desc	 Get the closest intersection point between a line segment and the edge of a rectangle.
///        x, y: the coordinates of the intersection point
///        angle: the angle to the intersection point
///        z: same as angle, for backward compatibility
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