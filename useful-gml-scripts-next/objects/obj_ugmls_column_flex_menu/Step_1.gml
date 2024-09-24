if (!enabled) exit;

control_state.poll_input();

/*
if (active_key_config != -1 && discovery_mode == MENU_DISCOVERY_MODE.DISCOVERING) {
	var _item = items[pos];	
	self.handle_key_config_discovery(_item);
	exit;
}
*/

if (control_state.pressed_state[MENU_CONTROLS.UP]) {
	if (active_key_config == -1) {
		var _cur_pos = pos;
		var _item = -1;
	
		do {
			pos = wrap(pos-1, 0, num_items);
			_item = items[pos];
		} until ((is_struct(_item)
			&& _item.type != "divider")
			|| _cur_pos == pos)
		
		/*var _should_scroll = self.update_view() && (pos < _cur_pos);
		if (_should_scroll) self.start_scroll_up();*/
		audio_play_sound(cursor_move_sfx, 1, false);
	}
}

if (control_state.pressed_state[MENU_CONTROLS.DOWN]) {
	if (active_key_config == -1) {
		var _cur_pos = pos;
		var _item = -1;
	
		do {
			pos = wrap(pos+1, 0, num_items);
			_item = items[pos];
		} until ((is_struct(_item)
			&& _item.type != "divider")
			|| _cur_pos == pos)		
		
		/*var _should_scroll = self.update_view() && (pos > _cur_pos);
		if (_should_scroll) self.start_scroll_down();*/
		audio_play_sound(cursor_move_sfx, 1, false);
	}
}