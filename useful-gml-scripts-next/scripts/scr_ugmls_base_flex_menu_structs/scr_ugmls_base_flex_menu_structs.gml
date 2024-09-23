/// @func  FlexMenuItem(config)
/// @param _config
//         - {Id.Instance} parent_menu
//         - {}            node
function FlexMenuItem(_config) constructor {
	type = "item";
	node = _config.node;
	parent_menu = _config.parent_menu;
	enabled = true;
	
	function set_enabled(_enabled) {
		enabled = _enabled;
	}

	function destroy() {}
}