cur_multiplier = wrap(cur_multiplier + 1, 0, array_length(multipliers));
red_timeline.set_time_step_multiplier(multipliers[cur_multiplier]);
blue_timeline.set_time_step_multiplier(multipliers[cur_multiplier]);