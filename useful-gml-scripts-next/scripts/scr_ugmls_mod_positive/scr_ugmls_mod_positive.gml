/// @desc  Returns n mod m, but the result is always positive
/// @param {real} _n 
/// @param {real} _m   
function mod_positive(_n, _m) {
  return ((_n mod _m) + _m) mod _m;
}