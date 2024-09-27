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

/// @param {string} _name
function _create_simple_node(_name) {
	return flexpanel_create_node({
		name: $"{_name}_root",
		width: item_width,
		height: item_height,
		padding: item_padding,
		margin: item_margin,
		marginLeft: item_margin + cursor_width,
		flexDirection: "row"
	});
}

/// @param {string} _name
function _create_spinner_node(_name) {
	var _root_node = flexpanel_create_node({
		name: $"{_name}_root",
		width: item_width,
		height: item_height,
		padding: item_padding,
		margin: item_margin,
		marginLeft: item_margin + cursor_width,
		flexDirection: "row"
	});
	
	var _label_node = flexpanel_create_node({
		name: $"{_name}_label",
		flexGrow: 1
	});
	
	var _left_node = flexpanel_create_node({
		name: $"{_name}_left",
		width: item_height
	});
	
	var _value_node = flexpanel_create_node({
		name: $"{_name}_value",
		width: item_height
	});
	
	var _right_node = flexpanel_create_node({
		name: $"{_name}_right",
		width: item_height
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

function update_layout() {
	flexpanel_calculate_layout(root_node, room_width, room_height, flexpanel_direction.LTR);
}

/// @param {Struct.FlexMenuSpinnerBase} _item
/// @param {string} _item_label
function _draw_spinner_base(_item, _item_label) {
	var _item_value = _item.get_value();
	var _label_node_pos = flexpanel_node_layout_get_position(_item.label_node, false);
	var _value_node_pos = flexpanel_node_layout_get_position(_item.value_node, false);
	var _left_node_pos = flexpanel_node_layout_get_position(_item.left_node, false);
	var _right_node_pos = flexpanel_node_layout_get_position(_item.right_node, false);
			
	if (item_draw_border) {
		draw_rectangle(_label_node_pos.left,
			_label_node_pos.top,
			_label_node_pos.left + _label_node_pos.width,
			_label_node_pos.top + _label_node_pos.height,
			true
		);
				
		draw_rectangle(_value_node_pos.left,
			_value_node_pos.top,
			_value_node_pos.left + _value_node_pos.width,
			_value_node_pos.top + _value_node_pos.height,
			true
		);
		
		draw_rectangle(_left_node_pos.left,
			_left_node_pos.top,
			_left_node_pos.left + _left_node_pos.width,
			_left_node_pos.top + _left_node_pos.height,
			true
		);

		draw_rectangle(_right_node_pos.left,
			_right_node_pos.top,
			_right_node_pos.left + _right_node_pos.width,
			_right_node_pos.top + _right_node_pos.height,
			true
		);
	}
			
	draw_text(_label_node_pos.left + _label_node_pos.paddingLeft,
		_label_node_pos.top + _label_node_pos.paddingTop,
		_item_label
	);
			
	draw_set_halign(fa_center);
	draw_text(_value_node_pos.left + _value_node_pos.width / 2,
		_value_node_pos.top + _value_node_pos.paddingTop,
		_item_value
	);
}

/// @param {Struct.FlexMenuSpinnerBase} _item
function _draw_spinner_arrows(_item) {
	var _left_node_pos = flexpanel_node_layout_get_position(_item.left_node, false);
	var _right_node_pos = flexpanel_node_layout_get_position(_item.right_node, false);
			
	draw_sprite_ext(spinner_scroll_arrows_spr, 0,
		_left_node_pos.left + _left_node_pos.width / 2,
		_left_node_pos.top + _left_node_pos.height / 2,
		1, 1, 90, c_white, 1
	);
			
	draw_sprite_ext(spinner_scroll_arrows_spr, 0,
		_right_node_pos.left + _right_node_pos.width / 2,
		_right_node_pos.top + _right_node_pos.height / 2,
		1, 1, 270, c_white, 1
	);
}

/// @param {Struct.FlexMenuItem} _item
/// @param {real} _i
function draw_menu_item(_item, _i) {
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	var _node = _item.root_node;
	var _node_pos = flexpanel_node_layout_get_position(_node, false);
	var _item_label = _item.label;
	var _item_label_height = string_height(_item_label);
	
	// Border
	if (item_draw_border) {
		draw_rectangle(_node_pos.left, _node_pos.top, _node_pos.left + _node_pos.width, _node_pos.top + _node_pos.height, true);
	}

	// Contents
	switch (_item.type) {
		case FLEX_MENU_ITEM_TYPE.ITEM:
		case FLEX_MENU_ITEM_TYPE.SELECTABLE:
		case FLEX_MENU_ITEM_TYPE.DIVIDER:
			draw_text(_node_pos.left + _node_pos.paddingLeft, _node_pos.top + _node_pos.paddingTop, _item_label);
			break;
		
		case FLEX_MENU_ITEM_TYPE.SPINNER_BASE:
		case FLEX_MENU_ITEM_TYPE.VALUED_SELECTABLE:
			_draw_spinner_base(_item, _item_label);
			break;
		
		case FLEX_MENU_ITEM_TYPE.SPINNER:
			_draw_spinner_base(_item, _item_label);
			_draw_spinner_arrows(_item);
			break;
			
		default:
			draw_text(_node_pos.left + _node_pos.paddingLeft, _node_pos.top + _node_pos.paddingTop, $"Unknown Item: {_node_label}");
	}
	
	// Cursor
	if (pos == _i) {
		draw_sprite(cursor_spr, 0, _node_pos.left - cursor_width, _node_pos.top  + _item_label_height / 2);
	}
}

function destroy() {
	flexpanel_delete_node(root_node, true);
}