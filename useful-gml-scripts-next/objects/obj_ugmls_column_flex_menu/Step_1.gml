if (!enabled) exit;

control_state.poll_input();

if (active_key_config != -1 && discovery_mode == MENU_DISCOVERY_MODE.DISCOVERING) {
	active_key_config.handle_discovery();
	exit;
}

if (control_state.pressed_state[MENU_CONTROLS.UP]) {
	if (active_key_config == -1) {
		var _cur_pos = pos;
		var _item = -1;
	
		do {
			pos = wrap(pos-1, 0, num_items);
			_item = items[pos];
		} until ((is_struct(_item)
			&& _item.type != FLEX_MENU_ITEM_TYPE.DIVIDER)
			|| _cur_pos == pos)
		
		var _should_scroll = self.update_view() && (pos < _cur_pos);
		if (_should_scroll) {
			start_scroll(-1);
		} else {
			reset_scroll();
		}
		
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
			&& _item.type != FLEX_MENU_ITEM_TYPE.DIVIDER)
			|| _cur_pos == pos)		
		
		var _should_scroll = self.update_view() && (pos > _cur_pos);
		if (_should_scroll) {
			start_scroll(1);
		} else {
			reset_scroll();
		}
		
		audio_play_sound(cursor_move_sfx, 1, false);
	}
}

if (control_state.pressed_state[MENU_CONTROLS.LEFT]) {
	var _item = items[pos];

	switch (_item.type) {
		case FLEX_MENU_ITEM_TYPE.SPINNER:	
			_item.handle_change(-1);
			break;
			
		case FLEX_MENU_ITEM_TYPE.KEY_CONFIG:
			if (active_key_config == _item) {
				_item.handle_select(-1);
			}
			break;
	}
}

if (control_state.pressed_state[MENU_CONTROLS.RIGHT]) {
	var _item = items[pos];

	switch (_item.type) {
		case FLEX_MENU_ITEM_TYPE.SPINNER:	
			_item.handle_change(1);
			break;
			
		case FLEX_MENU_ITEM_TYPE.KEY_CONFIG:
			if (active_key_config == _item) {
				_item.handle_select(1);
			}
			break;
	}
}

if (control_state.pressed_state[MENU_CONTROLS.CONFIRM]) {
	items[pos].handle_confirm();
} else if (control_state.pressed_state[MENU_CONTROLS.CANCEL]) {
	var _item = items[pos];
	
	switch (_item.type) {
		case FLEX_MENU_ITEM_TYPE.KEY_CONFIG:
			if (active_key_config == _item) {
				_item.handle_cancel();
			}
			break;
	}
} else if (control_state.pressed_state[MENU_CONTROLS.DELETE_BINDING]) {
	var _item = items[pos];	
		
	switch (_item.type) {
		case FLEX_MENU_ITEM_TYPE.KEY_CONFIG:
			if (active_key_config == _item) {
				_item.handle_delete();
			}
			break;
	}
}