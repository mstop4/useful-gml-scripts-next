/// @desc  Draws text with outline.
///				 Note: Recommended for drawing text with non-SDF fonts only. For SDF fonts, use the outline effect.
/// @param {real}    _x          
/// @param {real}    _y          
/// @param {string}  _string        
/// @param {real}    _xscale     
/// @param {real}    _yscale     
/// @param {real}    _angle      
/// @param {real}		 _inner_color colour
/// @param {real}		 _outline_color colour
/// @param {real}    _outline_width  
/// @param {real}    _alpha      
/// @param {real}		 _fidelity   
function draw_outlined_text(_x, _y, _string, _xscale, _yscale, _angle, _inner_color, _outline_color, _outline_width, _alpha, _fidelity) {
	draw_set_color(_outline_color);

	for (var _i=0; _i<360; _i+=360/_fidelity) {
	    draw_text_transformed_color(_x + lengthdir_x(_outline_width * _xscale, _i),
	                                 _y + lengthdir_y(_outline_width * _yscale, _i),
	                                 _string,_xscale,_yscale,_angle,_outline_color,_outline_color,_outline_color,_outline_color,_alpha);
	}

	draw_text_transformed_color(_x,_y,_string,_xscale,_yscale,_angle,_inner_color,_inner_color,_inner_color,_inner_color,_alpha);
}