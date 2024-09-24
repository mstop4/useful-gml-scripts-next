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

function destroy() {
	flexpanel_delete_node(root_node, true);
}