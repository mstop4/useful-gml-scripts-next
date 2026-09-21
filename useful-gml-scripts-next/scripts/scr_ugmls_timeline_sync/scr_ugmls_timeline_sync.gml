function TimelineSync() constructor {
	moments = [];
	current_moment_index = 0;
  
  /// @desc 
	/// @param {Real} _timestamp
	/// @param {Function} _callback
	function add_moment(_timestamp, _callback) {
		var _moment = new TimelinePlusMoment(_timestamp, _callback);
		array_push(moments, _moment);
		moments_sorted = false;
		
		if (_sort_timeline) self._sort_moments();
	}
}