/// @desc  Calculates total distance travelled with a given initial speed and constant deceleration value, based on the formula v^2 = u^2 / (2*a*d)
/// @param {Real} _initial_speed
/// @param {Real} _deceleration should be positive
function calculate_distance_travelled(_initial_speed, _deceleration) {
  return sqr(_initial_speed) / (2 * _deceleration);
}