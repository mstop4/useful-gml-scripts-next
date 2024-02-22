function TimelinePlus() constructor {
	moments = [];
	current_moment_index = 0;
	timer = 0;
	moments_sorted = true;
	
	/// @desc 
	/// @param {Real} _timestamp
	/// @param {Function} _callback
	function add_moment(_timestamp, _callback, _sort_timeline = false) {
		var _moment = new TimelinePlusMoment(_timestamp, _callback);
		array_push(moments, _moment);
		moments_sorted = false;
		
		if (_sort_timeline) self._sort_moments();
	}
	
	/// @desc 
	/// @param {Real} _index
	function remove_moment(_index) {
		array_delete(moments, _index, 1);
	}
	
	function _sort_moments() {
		array_sort(moments, function(_a, _b) {
			return _a.timestamp - _b.timestamp;
		});
		moments_sorted = true;
	}
	
	function set_timer(_timer) {
		timer = _timer;
		
		if (!moments_sorted) self._sort_moments();
		
		for (var _i=0; _i<array_length(moments); _i++) {
			if (moments[_i].timestamp >= timer) {
				current_moment_index = _i;
				break;
			}
		}
	}
	
	function start() {
		if (!moments_sorted) self._sort_moments();
		time_source_start(ts_ticker);
	}
	
	function pause() {
		time_source_stop(ts_ticker);
	}
	
	function stop() {
		time_source_stop(ts_ticker);
		current_moment_index = 0;
		timer = 0;
	}
	
	function _do_step(_context) {
		var _current_moment = _context.moments[_context.current_moment_index];
		if (_current_moment.timestamp <= _context.timer) {
			_current_moment.callback();
			_context.current_moment_index++;
			
			if (_context.current_moment_index >= array_length(_context.moments)) {
				time_source_stop(_context.ts_ticker);
			}
		}
		
		_context.timer++;
	}
	
	function cleanup() {
		time_source_destroy(ts_ticker);
		array_delete(moments, 0, array_length(moments));
	}
	
	ts_ticker = time_source_create(time_source_game, 1, time_source_units_frames, self._do_step, [self], -1);
}

/// @desc 
/// @param {Real} _timestamp
/// @param {Function} _callback
function TimelinePlusMoment(_timestamp, _callback) constructor {
	timestamp = _timestamp;
	callback = _callback;
}