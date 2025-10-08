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

/// @desc  Calculates the ray-sphere intersection.
/// @param {Struct.Ray3D} _ray
/// @param {Struct.Sphere} _sphere
/// @returns {real} Distance from ray origin to closest intersection point on sphere, as a multiple of ray's direction vector. Infinity = no hit
function ray_sphere_intersect_quad(_ray, _sphere) {
  // Convert to local space
  var _local_x = _ray.o.x - _sphere.c.x;
  var _local_y = _ray.o.y - _sphere.c.y;
  var _local_z = _ray.o.z - _sphere.c.z;

  // Compute A, B, C
  var _a = dot_product_3d(_ray.d.x, _ray.d.y, _ray.d.z, _ray.d.x, _ray.d.y, _ray.d.z);
	if (_a == 0) return infinity; // degenerate ray
  
  var _b = 2 * dot_product_3d(_ray.d.x, _ray.d.y, _ray.d.z, _local_x, _local_y, _local_z);
	var _c = dot_product_3d(_local_x, _local_y, _local_z, _local_x, _local_y, _local_z) - sqr(_sphere.r);
  
  // Find discriminant
  var _disc = _b * _b - 4 * _a * _c;

  // If discriminant < 0, ray misses sphere
  if (_disc < 0) return infinity;
    
  // Compute q
  var _q = _b < 0
    ? (-_b - sqrt(_disc)) / 2
    : (-_b + sqrt(_disc)) / 2;
    
  // Compute t0 and t1
  var _t0, _t1;
  
  if (abs(q) == 0) {
    // Tangent: both roots are the same
    _t0 = (-0.5 * _b) / _a;
    _t1 = _t0;
  } else {
    _t0 = _q / _a;
    _t1 = _c / _q;
  }
  
  // Make sure t0 is smaller than t1
  if (_t0 > _t1) {
    var _temp = _t0;
    _t0 = _t1;
    _t1 = _temp;
  }

  // If t1 < 0, object is behind ray, miss
  // If t0 < 0, the intersection point is at t1
  // else the intersection point is at t0
  if (_t1 < 0) return infinity;
    
  return _t0 < 0 ? _t1 : _t0;
}

/// @desc  Calculates the ray-sphere intersection.
/// @param {Struct.Ray3D} _ray Should be normalized
/// @param {Struct.Sphere} _sphere
/// @returns {bool} Whether the ray hits the sphere or not
function ray_sphere_intersect_geom_fast(_ray, _sphere) {
  var _e = _sphere.c.subtract(_ray.o);
  var _mag_sqr = dot_product_3d(_e.x, _e.y, _e.z, _e.x, _e.y, _e.z);
  var _r_sqr = _sphere.r * _sphere.r;
  var _e_dot_d = dot_product_3d(_e.x, _e.y, _e.z, _ray.d.x, _ray.d.y, _ray.d.z);
  var _offset = _r_sqr - (_mag_sqr - (_e_dot_d * _e_dot_d));
  return offset >= 0;
}

/// @desc  Calculates the ray-sphere intersection.
/// @param {Struct.Ray3D} _ray Should be normalized
/// @param {Struct.Sphere} _sphere
/// @returns {Struct} Whether the ray hits the sphere or not, and two hit points
function ray_sphere_intersect_geom_t(_ray, _sphere) {
  var _l = _sphere.c.subtract(_ray.o);
  var _tc = dot_product_3d(_l.x, _l.y, _l.z, _ray.d.x, _ray.d.y, _ray.d.z);
  
  if (_tc < 0) return {
    hit: false
  };
    
  // L dot L = magnitude^2 of L
  var _d_sqr = dot_product_3d(_l.x, _l.y, _l.z, _l.x, _l.y, _l.z) - (_tc * _tc);
  var _r_sqr = _sphere.r * _sphere.r;
  if (_d_sqr > _r_sqr) return {
    hit: false  
  };

  // t1 should always be <= t2
  var _t1c = sqrt(_r_sqr - _d_sqr);
  var _t1 = _tc - _t1c;
  var _t2 = _tc + _t1c;
  
  if (_t1 < 0 && _t2 < 0) return { hit: false }; 
  if (_t1 < 0) return {
    hit: true,
    tmin: _t2,
    tmax: _t2
  }
  
  return {
    hit: true,
    tmin: _t1,
    tmax: _t2
  };
}

function ray_box_intersect(_ray, _box, _min_t, _max_t) {
  var _tmin = -infinity;
  var _tmax = infinity;
  var _ray_origin;
  var _ray_dir;
  var _box_min;
  var _box_max;
  
  // X
  _ray_origin = _ray.o.x;
  _ray_dir = _ray.d.x;
  _box_min = _box.min_corner.x;
  _box_max = _box.max_corner.x;
  
  if (abs(_ray_dir) <= 0) {
    // Parallel
    if (_ray_origin < _box_min || _ray_origin > _box_max) return { hit: false };
  } else {
    var _t1 = (_box_min - _ray_origin) / _ray_dir;
    var _t2 = (_box_max - _ray_origin) / _ray_dir;
    
    if (_t1 > _t2) {
      var _temp = _t1;
      _t1 = _t2;
      _t2 = _temp;
    }
    
    _tmin = max(_tmin, _t1);
    _tmax = min(_tmax, _t2);
    
    if (_tmin > _tmax) return { hit: false };
  }
  
  // Y
  _ray_origin = _ray.o.y;
  _ray_dir = _ray.d.y;
  _box_min = _box.min_corner.y;
  _box_max = _box.max_corner.y;
  
  if (abs(_ray_dir) <= 0) {
    // Parallel
    if (_ray_origin < _box_min || _ray_origin > _box_max) return { hit: false };
  } else {
    var _t1 = (_box_min - _ray_origin) / _ray_dir;
    var _t2 = (_box_max - _ray_origin) / _ray_dir;
    
    if (_t1 > _t2) {
      var _temp = _t1;
      _t1 = _t2;
      _t2 = _temp;
    }
    
    _tmin = max(_tmin, _t1);
    _tmax = min(_tmax, _t2);
    
    if (_tmin > _tmax) return { hit: false };
  }
  
  // Z
  _ray_origin = _ray.o.z;
  _ray_dir = _ray.d.z;
  _box_min = _box.min_corner.z;
  _box_max = _box.max_corner.z;
  
  if (abs(_ray_dir) <= 0) {
    // Parallel
    if (_ray_origin < _box_min || _ray_origin > _box_max) return { hit: false };
  } else {
    var _t1 = (_box_min - _ray_origin) / _ray_dir;
    var _t2 = (_box_max - _ray_origin) / _ray_dir;
    
    if (_t1 > _t2) {
      var _temp = _t1;
      _t1 = _t2;
      _t2 = _temp;
    }
    
    _tmin = max(_tmin, _t1);
    _tmax = min(_tmax, _t2);
    
    if (_tmin > _tmax) return { hit: false };
  }
  
  // Clamp to allowed parameter range
  var _t1 = max(_tmin, _min_t);
  var _t2 = min(_tmax, _max_t);
  
  if (_t1 > _t2) return { hit: false };
    
  return {
    hit: true,
    tmin: _t1,
    tmax: _t2
  }
}
