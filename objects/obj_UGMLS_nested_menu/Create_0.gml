event_inherited();

/// @param {Struct} _config
//         - {Id.Instance}       player_controller
//         - {Asset.GMFont}   font
//				 - {real} column_width
//         - {Asset.GMSprite} cursor_spr
//         - {Asset.GMSound}  cursor_move_sfx
//         - {Asset.GMSound}  cursor_change_sfx
//         - {Asset.GMSound}  cursor_confirm_sfx
//				 - {bool} use_control_icons
//				 - {Array<Asset.GMSprite>} keyboard_icons
//				 - {Array<Asset.GMSprite>} gamepad_icons
function nested_menu_init(_config) {
	self.column_menu_init(_config);
	column_width = _config.column_width;
}

/// @param {real} _index
function nested_menu_get_item_by_index(_index) {
	// Feather ignore once GM1028
	return self.items[| _index];
}

/// @param {string} _label
/// @returns {any}
function nested_menu_get_item_by_label(_label) {
	for (var _i=0; _i<num_items; _i++) {
		if (self.items[| _i].label == _label) return self.submenu[| _i];
	}
	
	return noone;
}

/// @param {real} _index -1 = toggle root menu
function nested_menu_toggle_submenu_by_index(_index) {
	if (_index < -1 || _index >= self.num_items) return;
		self.active_item = noone;
	
	for (var _i=0; _i<self.num_items; _i++) {
		var _item = self.nested_menu_get_item_by_index(_i);
		var _submenu = _item.submenu;
		if (_index == _i) {
			_submenu.enabled = true;
			_submenu.visible = true;
			self.active_item = _item;
		} else {
			_submenu.enabled = false;
			_submenu.visible = false;
		}
	}

	self.active_item_index = _index;

}

/// @param {Struct} _config 
//				 - {obj_menu_base} submenu
//         - {string}				 label
//         - {function}			 on_confirm_func
//         - {array}				 on_confirm_args
//         - {boolean}			 silent_on_confirm
function nested_menu_add_submenu(_config) {
	var _new = new NestedMenuSubmenu(_config);
	ds_list_add(items, _new);
	num_items++;
	_new.parent_menu = self;
	_new.submenu.enabled = false;
	_new.submenu.visible = false;
	_new.submenu.x = self.x + self.column_width;
	_new.submenu.y = self.y;
	column_menu_update_view_area();
	return _new;
}

items = ds_list_create();
num_items = 0;
pos = 0;
active_item = noone;