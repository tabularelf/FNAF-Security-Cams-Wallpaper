/// @description Cat Judges your code
/* 
    |\__/,|   (`\
  _.|o o  |_   ) )
-(((---(((--------
Cat Judges your code
*/
var _backIndex = backIndex;
var _backSprite = backSprite;
if (static_timer == 0) {
	if (currentCamera.location == locations.HallwayLeftA) && !((animatronics.Foxy.foxyStage == 3) && (foxyAnimateRun < sprite_get_number(spr_foxy_run)-1) && (visitedFoxyRun)) {
		_backSprite = choose(_backSprite, spr_hallway_leftALightOff);
	}
	draw_sprite_ext(_backSprite, _backIndex, 0, 0, 1, 1, 0, c_white, alpha);
}