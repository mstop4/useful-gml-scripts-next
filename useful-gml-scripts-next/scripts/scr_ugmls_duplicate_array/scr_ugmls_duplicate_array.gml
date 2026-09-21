/// @desc	 Creates a new shallow copy of a given array.
/// @param {Array} _array
/// @deprecated Use built-in function variable_clone instead 
function duplicate_array(_array) {
	var _new_array = array_create(array_length(_array));
	array_copy(_new_array, 0, _array, 0, array_length(_array));
	return _new_array;
}