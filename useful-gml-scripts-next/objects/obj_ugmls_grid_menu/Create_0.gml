event_inherited();

items = ds_grid_create(1, 1);
items_width = 1;
items_height = 1;
pos = new Vector2(0, 0);
view_area = new Rectangle(0, 0, 0, 0);
view_scroll_progress_x = new Tween(0, 0, -1, 1, TWEEN_LIMIT_MODE.CLAMP, true, function() {});

/// @param {Struct} _config 
//         - {real}   width
//         - {real}   height
//		     - {real}   view_width
//         - {real}   view_height
//				 - {real} column_width
//				 - {Id.Instance} player_controller obj_player_controller
//         - {font}   label_font
//         - {font}   value_font
//         - {sprite} cursor_spr
//         - {sound}  cursor_move_sfx
//         - {sound}  cursor_change_sfx
//         - {sound}  cursor_confirm_sfx
//				 - {boolean} use_control_icons
//				 - {Array<Asset.GMSprite>} keyboard_icons
//				 - {Array<Asset.GMSprite>} gamepad_icons
grid_menu_init = method(self, function(_config) {
	self.menu_base_init(_config);
	
	column_width = _config.column_width;
	view_width = _config.view_width;
	view_height = _config.view_height;
	menu_label_font = _config.label_font;
	menu_value_font = _config.value_font;
	cursor_spr = _config.cursor_spr;
	cursor_padding = sprite_get_width(cursor_spr) + 16;
	cursor_move_sfx = _config.cursor_move_sfx;
	cursor_change_sfx = _config.cursor_change_sfx;
	cursor_confirm_sfx = _config.cursor_confirm_sfx;
	
	ds_grid_resize(self.items, _config.width, _config.height);
	items_width = _config.width;
	items_height = _config.height;
	
	view_area.left = 0;
	view_area.right = view_width < 1
		? _config.width - 1
		: _config.view_width - 1;


	view_area.top = 0;
	view_area.bottom = view_height < 1
		? _config.height - 1
		: _config.view_height - 1;
});

start_scroll_up = method(self, function() {
	view_scroll_progress_x.v = 0;
	view_scroll_progress_x.d = 0;
	view_scroll_progress_y.v = 1;
	view_scroll_progress_y.d = -1/view_scroll_duration;
});

start_scroll_down = method(self, function() {
	view_scroll_progress_x.v = 0;
	view_scroll_progress_x.d = 0;
	view_scroll_progress_y.v = -1;
	view_scroll_progress_y.d = 1/view_scroll_duration;
});

start_scroll_left = method(self, function() {
	view_scroll_progress_x.v = 1;
	view_scroll_progress_x.d = -1/view_scroll_duration;
	view_scroll_progress_y.v = 0;
	view_scroll_progress_y.d = 0;
});

start_scroll_right = method(self, function() {
	view_scroll_progress_x.v = -1;
	view_scroll_progress_x.d = 1/view_scroll_duration;
	view_scroll_progress_y.v = 0;
	view_scroll_progress_y.d = 0;
});

update_view = method(self, function() {
	var _changed = {
		x: false,
		y: false,
	};	
	
	if (view_height > 0) {
		if (pos.y < view_area.top) {
			view_area.top = pos.y;
			view_area.bottom = pos.y + view_height - 1;
			_changed.y = true;
		} else if (pos.y > view_area.bottom) {
			view_area.bottom = pos.y;
			view_area.top = pos.y - (view_height - 1);
			_changed.y = true;
		}
	}

	if (view_width > 0) {
		if (pos.x < view_area.left) {
			view_area.left = pos.x;
			view_area.right = pos.x + view_height - 1;
			_changed.x = true;
		} else if (pos.x > view_area.right) {
			view_area.right = pos.x;
			view_area.left = pos.x - (view_height - 1);
			_changed.x = true;
		}
	}
	
	return _changed;
});

/// @param {real} _x
/// @param {real} _y
get_item_by_index = method(self, function(_x, _y) {
	return items[# _x, _y];
});

/// @param {string} _label
/// @returns {any}
get_item_by_label = method(self, function(_label) {
	var _width = ds_grid_width(items);
	var _height = ds_grid_height(items);
	
	for (var _i=0; _i<_width; _i++) {
		for (var _j=0; _j<_height; _j++) {		
			if (_menu.items[# _i, _j].label == _label) return _menu.items[# _i, _j];
		}
	}
	
	return noone;
});

/// @param {real} _x
/// @param {real} _y
/// @param {Struct} _config
//         - {string}   label
//         - {function} on_confirm_func
//         - {array}    on_confirm_args
//         - {boolean}  silent_on_confirm
add_selectable = method(self, function(_x, _y, _config) {
	if (_x < 0 || _x >= ds_grid_width(self.items)
		|| _y < 0 || _y >= ds_grid_height(self.items))
			return;
	
	var _new = new MenuSelectable(_config);
	_new.parent_menu = id;
	self.items[# _x, _y] = _new;
	return _new;
});

/// @param {real} _x
/// @param {real} _y
/// @param {Struct} _config 
//         - {string}   label
//         - {string}   init_value
//         - {function} on_confirm_func
//         - {array}    on_confirm_args
//         - {function} on_change_func
//         - {array}    on_change_args
//         - {boolean}  silent_on_confirm
//         - {boolean}  silent_on_change
add_valued_selectable = method(self, function(_x, _y, _config) {
	if (_x < 0 || _x >= ds_grid_width(items)
		|| _y < 0 || _y >= ds_grid_height(items))
			return;
	
	var _new = new MenuValuedSelectable(_config);
	_new.parent_menu = id;
	items[# _x, _y] = _new;
	return _new;
});

/// @param {real} _x
/// @param {real} _y
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
add_spinner = method(self, function(_x, _y, _config) {
	if (_x < 0 || _x >= ds_grid_width(items)
		|| _y < 0 || _y >= ds_grid_height(items))
			return;
	
	var _new = new MenuSpinner(_config);
	_new.parent_menu = id;
	items[# _x, _y] = _new;
	return _new;
});

/// @param {real} _x
/// @param {real} _y
/// @param {Struct} _config 
//         - {string}   label
//				 - {CONTROLS} control
//         - {array}    initial_kbm_bindings
//         - {array}    initial_gamepad_bindings
//         - {function} on_change_func
//         - {array}    on_change_args
//         - {boolean}  silent_on_confirm
//         - {boolean}  silent_on_change
add_key_config = method(self, function(_x, _y, _config) {
	if (_x < 0 || _x >= ds_grid_width(items)
		|| _y < 0 || _y >= ds_grid_height(items))
			return;
			
	var _new = new MenuKeyConfig(_config);
	_new.parent_menu = id;
	items[# _x, _y] = _new;
	return _new;
});

/// @param {real} _x
/// @param {real} _y
/// @param {Struct} _config 
//         - {string}   label
add_divider = method(self, function(_x, _y, _config) {
	if (_x < 0 || _x >= ds_grid_width(items)
		|| _y < 0 || _y >= ds_grid_height(items))
			return;
			
	var _new = new MenuDivider(_config);
	_new.parent_menu = id;
	items[# _x, _y] = _new;
	return _new;
});