event_inherited();

show_debug_message($"{menu_width_items}, {menu_height_items}"); 

items = array_create(menu_height_items);
pos = new Vector2(0, 0);
view_area_x = new Vector2(0, 0);
view_area_y = new Vector2(0, 0);
view_scroll_progress_x = new Tween(0, 0, -1, 1, TWEEN_LIMIT_MODE.CLAMP, true, undefined, []);

function create_menu_structure() {
	root_node = flexpanel_create_node({
		name: "root",
		left: x,
		top: y,
		width: menu_max_width,
		height: menu_max_height,
	});
	
	alignment_node = flexpanel_create_node({
		name: "alignment",
		width: "100%",
		flexDirection: "row",
		alignItems: "center"
	});

	item_list_node = flexpanel_create_node({
		name: "item_list",
		flexDirection: "column",
		alignItems: "center"
	});
	
	scroll_up_node = flexpanel_create_node({
		name: "scroll_up",
		width: view_scroll_arrows_height,
		height: view_scroll_arrows_height,
	});
	
	scroll_down_node = flexpanel_create_node({
		name: "scroll_down",
		width: view_scroll_arrows_height,
		height: view_scroll_arrows_height,
	});
	
	scroll_left_node = flexpanel_create_node({
		name: "scroll_left",
		width: view_scroll_arrows_height,
		height: view_scroll_arrows_height,
	});
	
	scroll_right_node = flexpanel_create_node({
		name: "scroll_right",
		width: view_scroll_arrows_height,
		height: view_scroll_arrows_height,
	});

	flexpanel_node_insert_child(root_node, alignment_node, 0);
	flexpanel_node_insert_child(alignment_node, scroll_right_node, 0);
	flexpanel_node_insert_child(alignment_node, item_list_node, 0);
	flexpanel_node_insert_child(alignment_node, scroll_left_node, 0);
	flexpanel_node_insert_child(item_list_node, scroll_down_node, 0);
	
	row_nodes = array_create(menu_height_items);
	item_nodes = array_create(menu_height_items);
	
	// Allocate space
	for (var _i=0; _i<menu_height_items; _i++) {
		items[_i] = array_create(menu_width_items, undefined);
		item_nodes[_i] = array_create(menu_width_items, undefined);
	}

	for (var _i=0; _i<menu_height_items; _i++) {
		var _row_node = flexpanel_create_node({
			name: $"row_{_i}",
			width: "100%",
			height: item_height,
			margin: item_margin,
			flexDirection: "row",
			alignItems: "center"
		});
		
		row_nodes[_i] = _row_node;
		flexpanel_node_insert_child(item_list_node, _row_node, _i);
		
		for (var _j=0; _j<menu_width_items; _j++) {
			add_divider({
				label: "",
				x: _j,
				y: _i
			}, false);
		}
	}
	
	flexpanel_node_insert_child(item_list_node, scroll_up_node, 0);
	update_layout();
	update_view_area();
}

#region View

/// @returns {Bool}
function scroll_view() {
	var _changed = false;

	if (view_width > 0) {
		if (pos.x < view_area_x.x) {
			view_area_x.x = pos.x;
			view_area_x.y = pos.x + view_width - 1;
			_changed = true;
		} else if (pos.x > view_area_x.y) {
			view_area_x.y = pos.x;
			view_area_x.x = pos.x - (view_width - 1);
			_changed = true;
		}
	}
	
	if (view_height > 0) {
		if (pos.y < view_area_y.x) {
			view_area_y.x = pos.y;
			view_area_y.y = pos.y + view_height - 1;
			_changed = true;
		} else if (pos.y > view_area_y.y) {
			view_area_y.y = pos.y;
			view_area_y.x = pos.y - (view_height - 1);
			_changed = true;
		}
	}	
	
	return _changed;
}

function update_view_area() {
	if (view_width < 1) {
		view_area_x.x = 0;
		view_area_x.y = menu_width_items - 1;
	} else {
		view_area_x.x = min(pos.x, menu_width_items - view_width - 1);
		view_area_x.y = view_area_x.x + view_width - 1;
	}
	
	if (view_height < 1) {
		view_area_y.x = 0;
		view_area_y.y = menu_height_items - 1;
	} else {
		view_area_y.x = min(pos.y, menu_height_items - view_height - 1);
		view_area_y.y = view_area_y.x + view_height - 1;
	}
}

/// @param {bool} _vertical
/// @param {real} _delta
function start_scroll(_vertical, _delta) {
	if (_vertical) {
		view_scroll_progress_x.v = 0;
		view_scroll_progress_x.d = 0;
	
		view_scroll_progress_y.v = _delta;
		view_scroll_progress_y.d = -_delta/view_scroll_duration;
	} else {
		view_scroll_progress_y.v = 0;
		view_scroll_progress_y.d = 0;
	
		view_scroll_progress_x.v = _delta;
		view_scroll_progress_x.d = -_delta/view_scroll_duration;
	}
}

function reset_scroll() {
	view_scroll_progress_x.v = 0;
	view_scroll_progress_x.d = 0;
	
	view_scroll_progress_y.v = 0;
	view_scroll_progress_y.d = 0;
}

#endregion

#region Insert Items

/// @param {Pointer.FlexPanelNode} _node
/// @param {Struct.FlexMenuItem} _item
/// @param {real} _x
/// @param {real} _y
function _insert_item(_node, _item, _x, _y) {
	if (!is_undefined(item_nodes[_x][_y])) {
		flexpanel_node_remove_child(row_nodes[_x], item_nodes[_x][_y]);
		flexpanel_delete_node(item_nodes[_x][_y]);
	}
	
	flexpanel_node_insert_child(row_nodes[_y], _node, _x);
	item_nodes[_x][_y] = _node;
	items[_x][_y] = _item;
}

/// @param {Struct} _config
//       - {string} label
//       - {real}   x
//       - {real}   y
/// @param {bool} _update_layout
/// @returns {Struct.FlexMenuDivider or Undefined}
function add_divider(_config, _update_layout = false) {
	if (_config.x < 0 || _config.x >= menu_width_items
		|| _config.y < 0 || _config.y >= menu_height_items) {
		return undefined;
	}
	
	var _root_node = _create_simple_node(_config.label, item_width);
	
	var _item = new FlexMenuDivider({
		parent_menu: id,
		label: _config.label,
		root_node: _root_node,
		menu_data: {
			x: _config.x,
			y: _config.y
		},
	});
	
	_insert_item(_root_node, _item, _config.x, _config.y);
	
	if (_update_layout) {
		update_layout();
		update_view_area();
	}
	
	return _item;
}

/// @param {Struct} _config
//       - {string}      label
//       - {real}        x
//       - {real}        y
//       - {function}    on_confirm_func
//       - {array}       on_confirm_args
//       - {boolean}     silent_on_confirm
/// @param {bool} _update_layout
/// @returns {Struct.FlexMenuSelectable or Undefined}
function add_selectable(_config, _update_layout = false) {
	if (_config.x < 0 || _config.x >= menu_width_items
		|| _config.y < 0 || _config.y >= menu_height_items) {
		return undefined;
	}
	var _root_node = _create_simple_node(_config.label, item_width);
	
	var _item = new FlexMenuSelectable({
		parent_menu: id,
		label: _config.label,
		root_node: _root_node,
		menu_data: {
			x: _config.x,
			y: _config.y
		},
		on_confirm_func: _config.on_confirm_func,
		on_confirm_args: _config.on_confirm_args,
		silent_on_confirm: _config.silent_on_confirm
	});
	
	_insert_item(_root_node, _item, _config.x, _config.y);
	
	if (_update_layout) {
		update_layout();
		update_view_area();
	}
	
	return _item;
}

#endregion

/// @param {Struct.FlexMenuItem} _item
/// @param {real} _x
/// @param {real} _y
/// @param {real} _item_x_offset
/// @param {real} _item_y_offset
/// @param {real} _scroll_x_offset
/// @param {real} _scroll_y_offset
/// @param {real} _base_alpha
function draw_menu_item(_item, _x, _y, _item_x_offset, _item_y_offset, _scroll_x_offset, _scroll_y_offset, _base_alpha) {
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_set_alpha(_base_alpha);
	var _node = _item.root_node;
	var _node_pos = flexpanel_node_layout_get_position(_node, false);
	var _item_label = _item.label;
	var _x_offset = -_item_x_offset * (_node_pos.width + _node_pos.marginLeft + _node_pos.marginRight) + _scroll_x_offset;
	var _y_offset = -_item_y_offset * (_node_pos.height + _node_pos.marginTop + _node_pos.marginBottom) + _scroll_y_offset;
	
	// Border
	if (item_draw_border) {
		draw_rectangle(
			_node_pos.left + _x_offset,
			_node_pos.top + _y_offset,
			_node_pos.left + _node_pos.width + _x_offset,
			_node_pos.top + _node_pos.height + _y_offset,
			true
		);
	}

	// Contents
	switch (_item.type) {
		case FLEX_MENU_ITEM_TYPE.ITEM:
		case FLEX_MENU_ITEM_TYPE.SELECTABLE:
		case FLEX_MENU_ITEM_TYPE.DIVIDER:
			if (_item_label != "") {
				draw_set_font(label_font);
				draw_text(
					_node_pos.left + _node_pos.paddingLeft + _x_offset,
					_node_pos.top + _node_pos.height / 2 + _y_offset,
					_item_label
				);
			}
			break;
		
		/*case FLEX_MENU_ITEM_TYPE.SPINNER_BASE:
		case FLEX_MENU_ITEM_TYPE.VALUED_SELECTABLE:
			_draw_spinner_base(_item, _item_label, _y_offset);
			break;
		
		case FLEX_MENU_ITEM_TYPE.SPINNER:
			_draw_spinner_base(_item, _item_label, _y_offset);

			if (enabled && pos == _i) {
				_draw_spinner_arrows(_item, _y_offset, _base_alpha);
			}

			break;
			
		case FLEX_MENU_ITEM_TYPE.KEY_CONFIG:
			_draw_key_config(_item, _item_label, _y_offset, _base_alpha);
			break;*/
			
		default:
			draw_set_font(label_font);
			draw_text(
				_node_pos.left + _node_pos.paddingLeft + _x_offset,
				_node_pos.top + _node_pos.paddingTop + _y_offset,
				$"Unknown Item: {_item_label}"
			);
	}
	
	// Cursor
	if (enabled && pos.x == _x && pos.y == _y) {
		draw_sprite_ext(
			cursor_spr,
			0,
			_node_pos.left + _x_offset,
			_node_pos.top + _node_pos.height / 2 + _y_offset,
			1, 1, 0, c_white, menu_alpha.v
		);
	}
}

create_menu_structure();