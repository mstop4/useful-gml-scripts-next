/// @desc	 Chooses a random element from an array, but does not remove it.
/// @param {Array} _array
function choose_from_array(_array) {
	return _array[irandom(array_length(_array)-1)];
}