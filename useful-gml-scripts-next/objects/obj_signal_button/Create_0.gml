event_inherited();

/// @desc Manually dispatches "change_colour" signal when button is clicked
function on_click() {
	inst_signal_manager_demo_controller.signal_manager.dispatch("change_colour");
}
