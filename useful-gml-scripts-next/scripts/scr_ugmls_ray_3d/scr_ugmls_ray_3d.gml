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
