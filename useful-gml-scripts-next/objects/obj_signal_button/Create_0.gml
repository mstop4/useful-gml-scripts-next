event_inherited();

function on_click() {
	inst_signal_manager_demo_controller.signal_manager.dispatch("change_colour");
}
