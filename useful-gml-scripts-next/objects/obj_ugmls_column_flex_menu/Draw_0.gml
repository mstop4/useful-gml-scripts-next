event_inherited();

// Menu Items
var _num_children = flexpanel_node_get_num_children(root_node);

for (var _i = 0; _i < _num_children; _i++) {
	var _child = flexpanel_node_get_child(root_node, _i);
	var _child_pos = flexpanel_node_layout_get_position(_child, false);
	var _child_label = flexpanel_node_get_name(_child);
	
	draw_rectangle(_child_pos.left, _child_pos.top, _child_pos.left + _child_pos.width, _child_pos.top + _child_pos.height, true);
	draw_text(_child_pos.left + _child_pos.paddingLeft, _child_pos.top + _child_pos.paddingTop, _child_label);
}