if (!enabled) exit;

control_state.poll_input();

if (active_key_config != -1 && discovery_mode == MENU_DISCOVERY_MODE.DISCOVERING) {
	active_key_config.handle_discovery();
	exit;
}

if (control_state.pressed_state[MENU_CONTROLS.UP]) {
	if (active_key_config == -1) {
		var _cur_pos = pos.y;
		var _item = -1;
	
		do {
			pos.y = wrap(pos.y-1, 0, menu_height_items);
			_item = items[pos.x][pos.y];
		} until ((is_struct(_item)
			&& _item.type != FLEX_MENU_ITEM_TYPE.DIVIDER)
			|| _cur_pos == pos.y)
		
		var _should_scroll = self.scroll_view() && (pos.y < _cur_pos);
		if (_should_scroll) {
			start_scroll(true, -1);
		} else {
			reset_scroll();
		}
		
		audio_play_sound(cursor_move_sfx, 1, false);
	}
}

if (control_state.pressed_state[MENU_CONTROLS.DOWN]) {
	if (active_key_config == -1) {
		var _cur_pos = pos.y;
		var _item = -1;
	
		do {
			pos.y = wrap(pos.y+1, 0, menu_height_items);
			_item = items[pos.x][pos.y];
		} until ((is_struct(_item)
			&& _item.type != FLEX_MENU_ITEM_TYPE.DIVIDER)
			|| _cur_pos == pos.y)		
		
		var _should_scroll = self.scroll_view() && (pos.y > _cur_pos);
		if (_should_scroll) {
			start_scroll(true, 1);
		} else {
			reset_scroll();
		}
		
		audio_play_sound(cursor_move_sfx, 1, false);
	}
}

if (control_state.pressed_state[MENU_CONTROLS.LEFT]) {
	if (active_key_config == -1) {
		var _cur_pos = pos.x;
		var _item = -1;
	
		do {
			pos.x = wrap(pos.x-1, 0, menu_width_items);
			_item = items[pos.x][pos.y];
		} until ((is_struct(_item)
			&& _item.type != FLEX_MENU_ITEM_TYPE.DIVIDER)
			|| _cur_pos == pos.x)		
		
		var _should_scroll = self.scroll_view() && (pos.x < _cur_pos);
		if (_should_scroll) {
			start_scroll(false, -1);
		} else {
			reset_scroll();
		}
		
		audio_play_sound(cursor_move_sfx, 1, false);
	}	
	
	/*var _item = items[pos];

	switch (_item.type) {
		case FLEX_MENU_ITEM_TYPE.SPINNER:	
			_item.handle_change(-1);
			break;
			
		case FLEX_MENU_ITEM_TYPE.KEY_CONFIG:
			if (active_key_config == _item) {
				_item.handle_select(-1);
			}
			break;
	}*/
}

if (control_state.pressed_state[MENU_CONTROLS.RIGHT]) {
	if (active_key_config == -1) {
		var _cur_pos = pos.x;
		var _item = -1;
	
		do {
			pos.x = wrap(pos.x+1, 0, menu_width_items);
			_item = items[pos.x][pos.y];
		} until ((is_struct(_item)
			&& _item.type != FLEX_MENU_ITEM_TYPE.DIVIDER)
			|| _cur_pos == pos.x)		
		
		var _should_scroll = self.scroll_view() && (pos.x > _cur_pos);
		if (_should_scroll) {
			start_scroll(false, 1);
		} else {
			reset_scroll();
		}
		
		audio_play_sound(cursor_move_sfx, 1, false);
	}	
	
	/*var _item = items[pos];

	switch (_item.type) {
		case FLEX_MENU_ITEM_TYPE.SPINNER:	
			_item.handle_change(1);
			break;
			
		case FLEX_MENU_ITEM_TYPE.KEY_CONFIG:
			if (active_key_config == _item) {
				_item.handle_select(1);
			}
			break;
	}*/
}

if (control_state.pressed_state[MENU_CONTROLS.CONFIRM]) {
	items[pos.x][pos.y].handle_confirm();
} else if (control_state.pressed_state[MENU_CONTROLS.CANCEL]) {
	var _item = items[pos.x][pos.y];
	
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