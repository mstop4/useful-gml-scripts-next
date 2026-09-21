/// @desc	 Creates a new shallow copy of part of a given array.
/// @param {Array} _array
/// @param {Real} _start
/// @param {Real} _length
function array_slice(_array, _start, _length) {
	var _new_array = array_create(_length);
	array_copy(_new_array, 0, _array, _start, _length);
	return _new_array;
}