/// @desc  Calculates the ray-sphere intersection using the geometric method. This faster version only return whether a hit occurs or not, not the location of the hit
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