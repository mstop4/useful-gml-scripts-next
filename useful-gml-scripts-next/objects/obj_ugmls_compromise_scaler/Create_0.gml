application_surface_draw_enable(false);
upscale_surf = -1;

application_size = new Vector2(
	surface_get_width(application_surface),
	surface_get_height(application_surface)
);

window_size = new Vector2(
	window_get_width(),
	window_get_height()
);

screen_size = new Vector2(
	window_size.x,
	window_size.y
);

integer_scale = 1;
true_scale = 1;

upscale_surf = surface_create(application_size.x * integer_scale, application_size.y * integer_scale);

function _calculate_scale_factors() {
	var _width_ratio = screen_size.x / application_size.x;
	var _height_ratio = screen_size.y / application_size.y;
	
	true_scale = min(_width_ratio, _height_ratio);
	integer_scale = floor(true_scale);
}

_on_screen_mode_change = method(id, function () {
	_calculate_scale_factors();
	surface_resize(upscale_surf, application_size.x * integer_scale, application_size.y * integer_scale);
});

function change_application_surface_size(_width, _height) {
	surface_resize(application_surface, _width, _height);
	application_size.x = _width;
	application_size.y = _height;
}

function change_screen_mode(_screen_mode, _width = -1, _height = -1) {
	switch (_screen_mode) {
		case UGMLS_COMPROMISE_SCALER_SCREEN_MODE.WINDOWED:
			if (_width != -1) window_size.x = _width;
			if (_height != -1) window_size.y = _height;
			
			screen_size.x = window_size.x;
			screen_size.y = window_size.y;
			
			window_set_fullscreen(false);
			window_set_size(window_size.x, window_size.y);
			window_center();
			
			_calculate_scale_factors();
			surface_resize(upscale_surf, application_size.x * integer_scale, application_size.y * integer_scale);
			break;

		case UGMLS_COMPROMISE_SCALER_SCREEN_MODE.FULLSCREEN:	
			screen_size.x = display_get_width();
			screen_size.y = display_get_height();
			
			window_enable_borderless_fullscreen(false);
			window_set_fullscreen(true);
			
			call_later(1, time_source_units_frames, _on_screen_mode_change);
			break;
		case UGMLS_COMPROMISE_SCALER_SCREEN_MODE.BORDERLESS_FULLSCREEN:
			screen_size.x = display_get_width();
			screen_size.y = display_get_height();
			
			window_enable_borderless_fullscreen(true);
			window_set_fullscreen(true);
			
			call_later(1, time_source_units_frames, _on_screen_mode_change);
			break;
		default:
			show_debug_message("WAT");
	}
}