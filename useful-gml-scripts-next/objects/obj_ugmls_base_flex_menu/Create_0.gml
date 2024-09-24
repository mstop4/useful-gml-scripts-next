root_node = flexpanel_create_node({
	name: "root",
	left: x,
	top: y,
	width: menu_max_width,
	height: menu_max_height,
	padding: menu_padding
});

control_state = new MenuControlState(player_controller);

active_key_config = -1;
discovery_mode = FLEX_MENU_DISCOVERY_MODE.NONE;

/// @ {string} _percent_str
/// @ {real} _full_value
function convert_percent_to_px(_percent_str, _full_value) {
	// TODO: This won't work with strings like "%100%%%1234%"
	if (is_string(_percent_str)) {
		var _percent_pos = string_pos("%", _percent_str);
		if (_percent_pos == 0) return 0;
		
		var _percent_value_str = string_copy(_percent_str, 1, _percent_pos - 1);
		var _percent_value = real(_percent_value_str);
		return _percent_value * _full_value;
	}
	
	else return 0;
}

function update_layout() {
	flexpanel_calculate_layout(root_node, room_width, room_height, flexpanel_direction.LTR);
}

/// @param {Struct.FlexMenuItem} _item
/// @param {real} _i
function draw_menu_item(_item, _i) {
	var _node = _item.node;
	var _node_pos = flexpanel_node_layout_get_position(_node, false);
	var _node_label = flexpanel_node_get_name(_node);
	var _node_label_height = string_height(_node_label);
	
	// Border
	if (item_draw_border) {
		draw_rectangle(_node_pos.left, _node_pos.top, _node_pos.left + _node_pos.width, _node_pos.top + _node_pos.height, true);
	}

	// Contents
	switch (_item.type) {
		case FLEX_MENU_ITEM_TYPE.ITEM:
		case FLEX_MENU_ITEM_TYPE.SELECTABLE:
		case FLEX_MENU_ITEM_TYPE.DIVIDER:
			draw_text(_node_pos.left + _node_pos.paddingLeft, _node_pos.top + _node_pos.paddingTop, _node_label);
			break;
			
		default:
			draw_text(_node_pos.left + _node_pos.paddingLeft, _node_pos.top + _node_pos.paddingTop, $"Unknown Item: {_node_label}");
	}
	
	// Cursor
	if (pos == _i) {
		draw_sprite(cursor_spr, 0, _node_pos.left - cursor_width, _node_pos.top  + _node_label_height / 2);
	}
}

/// @param {Struct.FlexMenuSelectable} _item
function handle_selectable_confirm(_item) {
	if (!_item.enabled) return;
	if (is_callable(_item.on_confirm_func)) {
		_item.on_confirm_func(_item.on_confirm_args);
	}

	if (!_item.silent_on_confirm && audio_exists(cursor_confirm_sfx)) {
		audio_play_sound(cursor_confirm_sfx, 1, false);
	}
}

function destroy() {
	flexpanel_delete_node(root_node, true);
}