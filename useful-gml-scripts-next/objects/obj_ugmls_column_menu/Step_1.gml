if (!enabled) exit;

control_state.poll_input();

if (active_key_config != -1 && discovery_mode == MENU_DISCOVERY_MODE.DISCOVERING) {
	var _item = items[pos];	
	self.handle_key_config_discovery(_item);
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
			&& _item.type != "divider")
			|| _cur_pos == pos)
		
		var _should_scroll = self.update_view() && (pos < _cur_pos);
		if (_should_scroll) self.start_scroll_up();
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
		
		var _should_scroll = self.update_view() && (pos > _cur_pos);
		if (_should_scroll) self.start_scroll_down();
		audio_play_sound(cursor_move_sfx, 1, false);
	}
}

if (control_state.pressed_state[MENU_CONTROLS.LEFT]) {
	var _item = items[pos];

	if (_item.type == "spinner")
		self.handle_spinner_change(_item, -1);
		
	else if (_item.type == "keyconfig"
		&& active_key_config == _item)
		self.handle_key_config_select(_item, -1);
}

if (control_state.pressed_state[MENU_CONTROLS.RIGHT]) {
	var _item = items[pos];

	if (_item.type == "spinner")
		self.handle_spinner_change(_item, 1);
		
	else if (_item.type == "keyconfig"
		&& active_key_config == _item)
		self.handle_key_config_select(_item, 1);
}

if (control_state.pressed_state[MENU_CONTROLS.CONFIRM]) {
	var _item = items[pos];	
	
	if (_item.type == "spinner")
		self.handle_spinner_confirm(_item);
	
	else if (_item.type == "selectable")
		self.handle_selectable_confirm(_item);
		
	else if (_item.type == "valuedSelectable")
		self.handle_valued_selectable_confirm(_item);
		
	else if (_item.type == "keyconfig")
		self.handle_key_config_confirm(_item);
}

if (control_state.pressed_state[MENU_CONTROLS.CANCEL]) {
	var _item = items[pos];	
		
	if (_item.type == "keyconfig")
		self.handle_key_config_cancel(_item);
}

if (control_state.pressed_state[MENU_CONTROLS.DELETE_BINDING]) {
	var _item = items[pos];	
		
	if (_item.type == "keyconfig")
		self.handle_key_config_delete(_item);
}