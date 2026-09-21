/// @desc  A sphere defined by center "c" and radius "r"
/// @param {real} _cx
/// @param {real} _cy
/// @param {real} _cz
/// @param {real} _radius
function Sphere(_cx, _cy, _cz, _radius) constructor {
  c = new Vector3(_cx, _cy, _cz);
  r = _radius;
}
