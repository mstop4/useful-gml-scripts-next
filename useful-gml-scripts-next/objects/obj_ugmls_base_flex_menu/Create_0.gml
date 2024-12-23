control_state = new MenuControlState(player_controller);

active_key_config = -1;
discovery_mode = FLEX_MENU_DISCOVERY_MODE.NONE;
next_menu = noone;
showing = true;

view_scroll_progress_y = new Tween(0, 0, -1, 1, TWEEN_LIMIT_MODE.CLAMP, true, undefined, []);

/// @param {string} _percent_str
/// @param {real} _full_value
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

/// @returns {bool}
function can_interact() {
	return enabled && showing;
}

#region Node Creation

/// @param {string} _name
/// @param {string or real} _width
function _create_simple_node(_name, _width) {
	return flexpanel_create_node({
		name: $"{_name}_root",
		width: _width,
		height: item_height,
		padding: item_padding,
		paddingLeft: item_padding + cursor_offset_x,
		margin: item_margin,
		flexDirection: "row"
	});
}

/// @param {string} _name
/// @param {string or real} _width
/// @param {real} _value_node_width
function _create_spinner_node(_name, _width, _value_node_width) {
	var _root_node = flexpanel_create_node({
		name: $"{_name}_root",
		width: _width,
		height: item_height,
		padding: item_padding,
		paddingLeft: item_padding + cursor_offset_x,
		margin: item_margin,
		flexDirection: "row"
	});
	
	var _label_node = flexpanel_create_node({
		name: $"{_name}_label",
		flexGrow: 1
	});
	
	var _left_node = flexpanel_create_node({
		name: $"{_name}_left",
		width: _value_node_width
	});
	
	var _value_node = flexpanel_create_node({
		name: $"{_name}_value",
		width: _value_node_width
	});
	
	var _right_node = flexpanel_create_node({
		name: $"{_name}_right",
		width: _value_node_width
	});
	
	flexpanel_node_insert_child(_root_node, _label_node, 0);
	flexpanel_node_insert_child(_root_node, _left_node, 1);
	flexpanel_node_insert_child(_root_node, _value_node, 2);
	flexpanel_node_insert_child(_root_node, _right_node, 3);	
	
	return {
		root: _root_node,
		label: _label_node,
		left: _left_node,
		value: _value_node,
		right: _right_node,
	};
}

/// @param {string} _name
/// @param {string or real} _width
/// @param {real} _num_bindings
/// @param {real} _value_node_width
function _create_key_config_node(_name, _width, _num_bindings, _value_node_width) {
	var _root_node = flexpanel_create_node({
		name: $"{_name}_root",
		width: _width,
		height: item_height,
		padding: item_padding,
		paddingLeft: item_padding + cursor_offset_x,
		margin: item_margin,
		flexDirection: "row"
	});
	
	var _label_node = flexpanel_create_node({
		name: $"{_name}_label",
		flexGrow: 1
	});
	
	flexpanel_node_insert_child(_root_node, _label_node, 0);
	
	var _binding_nodes = [];
	
	for (var _i=0; _i<_num_bindings; _i++) {
		var _binding_node = flexpanel_create_node({
			name: $"{_name}_binding_{_i}",
			width: _value_node_width
		});
		
		flexpanel_node_insert_child(_root_node, _binding_node, _i + 1);
		array_push(_binding_nodes, _binding_node);
	}
	
	return {
		root: _root_node,
		label: _label_node,
		bindings: _binding_nodes
	};
}

#endregion

function update_layout() {
	flexpanel_calculate_layout(root_node, room_width, room_height, flexpanel_direction.LTR);
}

/// @param {bool} _visible
/// @param {bool} _immediate
function toggle_visibility(_visible, _immediate) {
	if (_immediate) {
		menu_alpha.v = _visible;
		visible = _visible;
		showing = _visible;
		_on_visibility_fade_end();
	} else {
		visible = true;
		if (_visible) {
			menu_alpha.v = 0;
			menu_alpha.d = 1/menu_fade_duration;
		} else {
			menu_alpha.v = 1;
			menu_alpha.d = -1/menu_fade_duration;
			showing = false;
		}
	}
}

_on_visibility_fade_end = method(self, function(_tween, _args) {
	if (menu_alpha.v == 0) {
		visible = false;
		
		if (next_menu != noone) {
			next_menu.toggle_visibility(true);
			next_menu = noone;
		}
	} else {
		showing = true;
	}
});

/// @param {Id.Instance} _next_menu
function menu_switch(_next_menu) {
	next_menu = _next_menu;
	toggle_visibility(false, false);
}

function destroy() {
	flexpanel_delete_node(root_node, true);
}

menu_alpha = new Tween(1, 0, 0, 1, TWEEN_LIMIT_MODE.CLAMP,  true, _on_visibility_fade_end);