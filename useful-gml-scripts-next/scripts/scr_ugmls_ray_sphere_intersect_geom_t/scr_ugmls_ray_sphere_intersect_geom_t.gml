/// @desc  Calculates the ray-sphere intersection using a geometric algorithm
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