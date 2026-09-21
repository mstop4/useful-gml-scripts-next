/// @desc  Calculates the ray-sphere intersection using a quadratic algorithm
/// @param {Struct.Ray3D} _ray
/// @param {Struct.Sphere} _sphere
/// @returns {real} Distance from ray origin to closest intersection point on sphere, as a multiple of ray's direction vector. Infinity = no hit
/// @deprecated Use ray_sphere_intersect_geom_t or Use ray_sphere_intersect_geom_fast instead
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