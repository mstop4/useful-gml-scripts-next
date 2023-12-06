event_inherited();

items = [];
num_items = 0;
pos = 0;
view_area = new Vector2(0, 0);

/// @param _config
//         - {real} view_height
//				 - {Id.Instance}       player_controller
//         - {font}   label_font
//         - {font}   value_font
//				 - {boolean} use_control_icons
//				 - {Array.<Sprite>} keyboard_icons
//				 - {Array.<Sprite>} gamepad_icons
//         - {sprite} cursor_spr
//         - {sound}  cursor_move_sfx
//         - {sound}  cursor_change_sfx
//         - {sound}  cursor_confirm_sfx
column_menu_init = method(self, function(_config) {
	self.menu_base_init(_config);
	
  view_height = _config.view_height;
	menu_label_font = _config.label_font;
	menu_value_font = _config.value_font;
	cursor_spr = _config.cursor_spr;
	cursor_padding = sprite_get_width(cursor_spr) + 16;
	cursor_move_sfx = _config.cursor_move_sfx;
	cursor_change_sfx = _config.cursor_change_sfx;
	cursor_confirm_sfx = _config.cursor_confirm_sfx;
});

update_view = method(self, function() {
	var _changed = false;

	if (view_height > 0) {
		if (pos < view_area.x) {
			view_area.x = pos;
			view_area.y = pos + view_height - 1;
			_changed = true;
		} else if (pos > view_area.y) {
			view_area.y = pos;
			view_area.x = pos - (view_height - 1);
			_changed = true;
		}
	}
	return _changed;
});

update_view_area = method(self, function() {
	view_area.y = view_height < 1
		? num_items - 1
		: min(num_items, pos + view_height - 1);
});

/// @param {real} _index
get_item_by_index = method(self, function(_index) {
	return self.items[_index];
});

/// @param {string} _label
get_item_by_label = method(self, function(_label) {
	for (var _i=0; _i<num_items; _i++) {
		if (self.items[_i].label == _label) return self.items[_i];
	}
	return noone;
});

/// @param {Struct} _config 
//         - {string}   label
//         - {function} on_confirm_func
//         - {array}    on_confirm_args
//         - {boolean}  silent_on_confirm
add_selectable = method(self, function(_config) {
	var _new = new MenuSelectable(_config);
	array_push(self.items, _new);
	num_items++;
	_new.parent_menu = self.id;
	self.update_view_area();
	return _new;
});

/// @param {Struct} _config 
//         - {string}   label
//         - {string}   init_value
//         - {function} on_confirm_func
//         - {array}    on_confirm_args
//         - {function} on_change_func
//         - {array}    on_change_args
//         - {boolean}  silent_on_confirm
//         - {boolean}  silent_on_change
add_valued_selectable = method(self, function(_config) {
	var _new = new MenuValuedSelectable(_config);
	array_push(self.items, _new);
	num_items++;
	_new.parent_menu = self.id;
	self.update_view_area();
	return _new;
});

/// @param {Struct} _config 
//         - {string}   label
//         - {array}    values
//         - {integer}  init_index
//         - {function} on_confirm_func
//         - {array}    on_confirm_args
//         - {function} on_change_func
//         - {array}    on_change_args
//         - {boolean}  silent_on_confirm
//         - {boolean}  silent_on_change
add_spinner = method(self, function(_config) {
	var _new = new MenuSpinner(_config);
	array_push(self.items, _new);
	num_items++;
	_new.parent_menu = self.id;
	self.update_view_area();
	return _new;
});

/// @param {Struct} _config 
//         - {string}   label
//				 - {CONTROLS} control
//         - {array}    initial_kbm_bindings
//         - {array}    initial_gamepad_bindings
//         - {function} on_change_func
//         - {array}    on_change_args
//         - {boolean}  silent_on_confirm
//         - {boolean}  silent_on_change
add_key_config = method(self, function(_config) {
	var _new = new MenuKeyConfig(_config);
	array_push(self.items, _new);
	num_items++;
	_new.parent_menu = self.id;
	self.update_view_area();
	return _new;
});

/// @param {Struct} _config 
//         - {string}   label
add_divider = method(self, function(_config) {
	var _new = new MenuDivider(_config);
	array_push(items, _new);
	num_items++;
	_new.parent_menu = self.id;
	update_view_area();
	return _new;
});