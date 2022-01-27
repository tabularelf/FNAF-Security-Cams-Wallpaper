function gmcallback_imgloadbar(){
	/// gmcallback_imgloadbar(context, current, total, canvas_width, canvas_height, image_width, image_height)
	var r;
	var pc = argument1; // progress current
	var pt = argument2; // progress total
	var cw = argument3; // canvas width
	var ch = argument4; // canvas height
	var iw = argument5; // image width
	var ih = argument6; // image height
	switch (argument0) {
	    case "image_rect":
	        r[0] = (current_time div 24) mod 48 * (iw div 48);
	        r[1] = 0;
	        r[2] = iw div 48;
	        r[3] = ih;
	        return r;
	    case "background_color": return c_black;
	    case "bar_background_color": return c_white;
	    case "bar_foreground_color": return $242238;
	    case "bar_border_color": return $242238;
	    case "bar_width": return round(cw * 0.6);
	    case "bar_height": return 20;
	    case "bar_border_width": return 2;
	    case "bar_offset": return 10;
	}
	return undefined;
}