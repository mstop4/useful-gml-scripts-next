/// @desc  A box defined by 2 corner points
/// @param {real} _ax
/// @param {real} _ay
/// @param {real} _az
/// @param {real} _bx
/// @param {real} _by
/// @param {real} _bz
function Box(_ax, _ay, _az, _bx, _by, _bz) constructor {
  min_corner = new Vector3(min(_ax, _bx), min(_ay, _by), min(_az, _bz));
  max_corner = new Vector3(max(_ax, _bx), max(_ay, _by), max(_az, _bz));
}