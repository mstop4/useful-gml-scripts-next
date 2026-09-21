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