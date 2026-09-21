/// @desc	 Compares all cells of two DS Grids for equality.
/// @param {Id.DsGrid} _grid1
/// @param {Id.DsGrid} _grid2
function grids_are_equal(_grid1, _grid2) {
	return ds_grid_write(_grid1) == ds_grid_write(_grid2);
}