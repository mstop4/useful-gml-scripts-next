/// @desc	 Converts gamepad constant to name as a string
/// @param {Constant.GamepadButton} _gp_constant 
function gamepad_constant_to_string (_gp_constant) {
	 switch (_gp_constant) {
		case gp_padu:
			return "UP";
		case gp_padd:
			return "DOWN";
		case gp_padl:
			return "LEFT";
		case gp_padr:
			return "RIGHT";
		case gp_face1:
			return "A";
		case gp_face2:
			return "B";
		case gp_face3:
			return "X";
		case gp_face4:
			return "Y";
		case gp_shoulderl:
			return "LT";
		case gp_shoulderr:
			return "RT";
		case gp_shoulderlb:
			return "LB";
		case gp_shoulderrb:
			return "RB";
		case gp_stickl:
			return "LS";
		case gp_stickr:
			return "RS";
		case gp_select:
			return "SELECT";
		case gp_start:
			return "START";
			
    default:
			return "???";
	 }
}