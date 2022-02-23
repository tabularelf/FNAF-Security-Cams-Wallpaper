function wrap(__value, __min, __max){
var value = floor(__value);
var _min = floor(min(__min, __max));
var _max = floor(max(__min, __max));
var range = _max - _min + 1; // + 1 is because max bound is inclusive

return (((value - _min) % range) + range) % range + _min;
}