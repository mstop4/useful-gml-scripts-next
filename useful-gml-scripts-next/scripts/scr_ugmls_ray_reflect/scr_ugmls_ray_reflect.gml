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