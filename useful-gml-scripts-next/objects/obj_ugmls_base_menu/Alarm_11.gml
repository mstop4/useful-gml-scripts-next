/// @desc fade out end
visible = false;

if (is_callable(on_fade_out_end)) {
	self.on_fade_out_end(on_fade_out_end_args);
	self.on_fade_out_end = pointer_null;
}

if (instance_exists(next_menu)) {
	next_menu.menu_fade_in();
}

next_menu = noone;