/// @desc	 Randomly shuffles the elements in a given array.
/// @param {Array} _array
/// @deprecated use array_shuffle instead
function shuffle_array(_array) {
  var _current_index = array_length(_array);
	var _random_index;

  // While there remain elements to shuffle
  while (_current_index != 0) {
    // Pick a remaining element
    _random_index = irandom(_current_index - 1);
    _current_index--;

    // And swap it with the current element
		var _temp = _array[_current_index];
		_array[_current_index] = _array[_random_index];
		_array[_random_index] = _temp;
  }

  return _array;
}