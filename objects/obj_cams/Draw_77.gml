/// @description Cat Judges your code
/* 
    |\__/,|   (`\
  _.|o o  |_   ) )
-(((---(((--------
Cat Judges your code
*/
if (global.animatronicsIsMoving <= 0) {
	shader_set(shd_bend);
	draw_surface_stretched(application_surface,0,0, browser_width, browser_height);
	shader_reset();
}