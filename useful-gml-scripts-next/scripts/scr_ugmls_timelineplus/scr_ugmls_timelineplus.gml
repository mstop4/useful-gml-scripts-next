function TimelinePlus() constructor {
	moments = [];
	current_moment_index = 0;
	timer = 0;
	moments_sorted = true;
  cleaning_up = false;
  
  /*
   * Step callback: function(timer, moment_progress, moment_length, next_moment); 
   * timer: total elapsed time in the timeline
   * moment_progress: time elapsed since previous moment
   * moment_length: time between previous moment and next moment
   * next_moment: the upcoming moment
   */
	
	/// @desc 
	/// @param {Real} _timestamp
  /// @param {Function} _end_callback
  /// @param {Array} _end_args
	/// @param {Function} _step_callback
	/// @param {Array} _step_args
	function add_moment(_timestamp, _end_callback, _end_args, _step_callback, _step_args, _sort_timeline = false) {
		var _moment = new TimelinePlusMoment(_timestamp, _end_callback, _end_args, _step_callback, _step_args);
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
    
    if (is_callable(_current_moment.step_callback)) {
      var _moment_length;
      
      if (current_moment_index > 0) {
        var _previous_moment = moments[current_moment_index - 1];
        _moment_length = _current_moment.timestamp - _previous_moment.timestamp;
      } else {
        _moment_length = _current_moment.timestamp;
      }
      
      var _moment_progress = _moment_length - (_current_moment.timestamp - timer); // reverse
      _current_moment.step_callback(timer, _moment_progress, _moment_length, _current_moment, _current_moment.step_args);
    }
    
		if (_current_moment.timestamp <= timer) {
      if (is_callable(_current_moment.end_callback)) _current_moment.end_callback(_current_moment.end_args);
			current_moment_index++;
			
			if (current_moment_index >= array_length(moments)) {
				time_source_stop(ts_ticker);
			}
		}
		
		timer++;
    if (cleaning_up) _garbage_collect();
	}
	
  function cleanup() {
    cleaning_up = true;
  }
  
	function _garbage_collect() {
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
  cleaning_up = false;
	
	/// @desc 
	/// @param {Real} _timestamp seconds or frames
	/// @param {Bool} _timestamp_is_frames
	/// @param {Function} _end_callback
	/// @param {Function} _step_callback
	/// @param {Bool} [_sort_timeline]
	function add_moment(_timestamp, _timestamp_is_frames, _end_callback, _end_args, _step_callback, _step_args, _sort_timeline = false) {
		// NOTE: There is an issue with sorting floating-point timestamps: https://github.com/YoYoGames/GameMaker-Bugs/issues/185
		// Because of this, timestamps only have millisecond resolution 
		var _timestamp_secs = _timestamp_is_frames
			? floor(_timestamp / game_get_speed(gamespeed_fps) * 1000)
			: _timestamp;
		
		var _moment = new TimelinePlusMoment(_timestamp, _end_callback, _end_args, _step_callback, _step_args);
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
		// NOTE: There is an issue with sorting floating-point timestamps: https://github.com/YoYoGames/GameMaker-Bugs/issues/185
		// Because of this, timestamps only have millisecond resolution 
		timer = _timestamp_is_frames
			? floor(_timestamp / game_get_speed(gamespeed_fps) * 1000)
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
    
    if (is_callable(_current_moment.step_callback)) {
      var _moment_length;
      
      if (current_moment_index > 0) {
        var _previous_moment = moments[current_moment_index - 1];
        _moment_length = _current_moment.timestamp - _previous_moment.timestamp;
      } else {
        _moment_length = _current_moment.timestamp;
      }
      
      var _moment_progress = _moment_length - (_current_moment.timestamp - timer); // reverse
      _current_moment.step_callback(timer, _moment_progress, _moment_length, _current_moment, _current_moment.step_args);
    }
    
		if (_current_moment.timestamp == timer) {
      if (is_callable(_current_moment.end_callback)) _current_moment.end_callback(_current_moment.end_args);
			current_moment_index++;
			
			if (current_moment_index >= array_length(moments)) {
				time_source_stop(ts_ticker);
			}
		}
		
		timer = min(timer + (delta_time * time_step_multiplier) / 1000, _current_moment.timestamp);
    if (cleaning_up) _garbage_collect();
	}
	
  function cleanup() {
    cleaning_up = true;
  }
  
	function _garbage_collect() {
		time_source_destroy(ts_ticker);
		array_delete(moments, 0, array_length(moments));
	}
	
	ts_ticker = time_source_create(time_source_game, 1, time_source_units_frames, method(self, _do_step), [], -1);
}