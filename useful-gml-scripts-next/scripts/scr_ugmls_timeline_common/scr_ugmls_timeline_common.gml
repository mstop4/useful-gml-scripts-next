/// @desc 
/// @param {Real} _timestamp
/// @param {Function} _end_callback
/// @param {Function} _step_callback
function TimelinePlusMoment(_timestamp, _end_callback, _step_callback) constructor {
	timestamp = _timestamp;
  step_callback = _step_callback;
	end_callback = _end_callback;
}