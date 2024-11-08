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
	
	function set_timer(_timestamp) {
		timer = _timestamp;
		
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
	
	function _do_step() {
		var _current_moment = moments[current_moment_index];
		if (_current_moment.timestamp <= timer) {
			_current_moment.callback();
			current_moment_index++;
			
			if (current_moment_index >= array_length(moments)) {
				time_source_stop(ts_ticker);
			}
		}
		
		timer++;
	}
	
	function cleanup() {
		time_source_destroy(ts_ticker);
		array_delete(moments, 0, array_length(moments));
	}
	
	ts_ticker = time_source_create(time_source_game, 1, time_source_units_frames, method(self, _do_step), [], -1);
}

function DeltaTimelinePlus() constructor {
	moments = [];
	current_moment_index = 0;
	timer = 0;
	time_step_multiplier = 1;
	moments_sorted = true;
	
	/// @desc 
	/// @param {Real} _timestamp seconds or frames
	/// @param {Bool} _timestamp_is_frames
	/// @param {Function} _callback
	function add_moment(_timestamp, _timestamp_is_frames, _callback, _sort_timeline = false) {
		var _timestamp_secs = _timestamp_is_frames
			? _timestamp / game_get_speed(gamespeed_fps)
			: _timestamp;
		
		var _moment = new TimelinePlusMoment(_timestamp_secs, _callback);
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
	
	/// @param {Real} _timestamp seconds or frames
	/// @param {Bool} _timestamp_is_frames
	function set_timer(_timestamp, _timestamp_is_frames) {
		timer = _timestamp_is_frames
			? _timestamp / game_get_speed(gamespeed_fps)
			: _timestamp;
		
		if (!moments_sorted) self._sort_moments();
		
		for (var _i=0; _i<array_length(moments); _i++) {
			if (moments[_i].timestamp >= timer) {
				current_moment_index = _i;
				break;
			}
		}
	}
	
	function set_time_step_multiplier(_multiplier) {
		time_step_multiplier = _multiplier;
	}
	
	function start(_sort_timeline = true) {
		// NOTE: There is an issue with sorting floating-point timestamps: https://github.com/YoYoGames/GameMaker-Bugs/issues/185
		if (_sort_timeline && !moments_sorted) self._sort_moments();
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
	
	function _do_step() {
		var _current_moment = moments[current_moment_index];
		while (_current_moment.timestamp <= timer) {
			_current_moment.callback();
			current_moment_index++;

			if (current_moment_index >= array_length(moments)) {
				time_source_stop(ts_ticker);
				break;
			} else {
				_current_moment = moments[current_moment_index];
			}
		}
		
		timer += (delta_time * time_step_multiplier) / 1000000;
	}
	
	function cleanup() {
		time_source_destroy(ts_ticker);
		array_delete(moments, 0, array_length(moments));
	}
	
	ts_ticker = time_source_create(time_source_game, 1, time_source_units_frames, method(self, _do_step), [], -1);
}

/// @desc 
/// @param {Real} _timestamp
/// @param {Function} _callback
function TimelinePlusMoment(_timestamp, _callback) constructor {
	timestamp = _timestamp;
	callback = _callback;
}