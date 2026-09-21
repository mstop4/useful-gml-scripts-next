/// @desc	 Chooses a random element from an arrray and removes it from the array.
/// @param {Array} _array
function pick_out_from_array(_array) {
	var _index = irandom(array_length(_array)-1);
	var _choice = _array[_index];
	array_delete(_array, _index, 1);
	
	return {
		value: _choice,
		index: _index
	};
}