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
