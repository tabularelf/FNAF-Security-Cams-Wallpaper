/// @description Cat Judges your code
/* 
    |\__/,|   (`\
  _.|o o  |_   ) )
-(((---(((--------
Cat Judges your code
*/

var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

if (paused) {
	draw_set_alpha(alpha);	
}

// Do while random hallucination is on
//draw_text(12, 32, batteryHTML5Get());

if (randomHallucinations) && !(paused) {
	draw_sprite_ext(spr_hallucinations, randomHallucinationsNum, 0, 0, 1, 1, 0, c_white, abs(sin(current_time/100)*.3));
}

// Render static
draw_sprite_ext(spr_static,	current_time*image_speed_get(spr_static), 0, 0, 1, 1, 0, c_white, min(game_settings.staticAlpha, alpha));

if (cameraChange) {
	draw_sprite_ext(spr_vhs_change,	cameraChangeIndex,0, 0, 1, 1, 0, c_white, game_settings.flashAlpha);	
}
	
// Render UI
// Site map
draw_sprite(spr_cam_border, 0, 0, 0);
draw_sprite(spr_site_map,0,864,320);

// Power/Usage Words
draw_set_font(numFontPower);
draw_sprite(spr_power_left, 0, 32, 652);
var _bat = 100;
if (os_browser != browser_not_a_browser) {
	_bat =  batteryHTML5Get()[1];	
	if (_bat == undefined) {
		_bat = 100;
	} else {
		_bat = _bat * 100;	
	}
} else {
	_bat = batteryPercent;
}

//_bat = (_bat mod 101);

draw_text(176, 644, _bat);
//draw_sprite(spr_num_9, 0, 176, 644);
//draw_sprite(spr_num_0, 0, 196 , 644);
//draw_sprite(spr_percent, 0, 220 , 652);
draw_sprite(spr_percent, 0, 176 + string_width(_bat) + 4 , 644 + (string_height(_bat)/2));


draw_sprite(spr_power_usage_sign, 0, 32, 680);
draw_sprite(spr_power_usage, 0,112, 672);

// Time
var _dateTime = date_current_datetime();//date_create_datetime(2005, 10, current_time / 1000, current_time / 1000, 0, 0);
var _hour = date_get_hour(_dateTime);
var _hourMod = _hour mod 12;
if (_hourMod == 0) {
	_hourMod = 12;	
}

draw_set_font(numFontTime);
draw_set_halign(fa_right);
draw_text(1204 - (sprite_get_width(spr_fontNumbersTime) div 4), 24, _hourMod);
draw_sprite(spr_am, (_hour div 12) mod 2, 1204, 26);

//draw_sprite(spr_num_2, 0,1172, 34);
//draw_sprite(spr_am, 0,1204, 36);

// Night
draw_set_halign(fa_left);
draw_set_font(numFontNights);
draw_sprite(spr_night, 0,1164, 58);
var _day = 1;
if (game_settings.isFirstDaySunday) {
	_day = date_get_weekday(_dateTime)+1;
} else {
	_day = wrap(date_get_weekday(_dateTime)-1, 0, 6); 	
	switch(_day) {
		case 0: _day = 1; break;
		case 1: _day = 2; break;
		case 2: _day = 3; break;
		case 3: _day = 4; break;
		case 4: _day = 5; break;
		case 5: _day = 6; break;
		case 6: _day = 7; break;
	}
}
draw_text(1232, 56, _day);
//draw_sprite(spr_num_3, 0,1236, 68);

// Rest of UI

// Camera Button
draw_sprite(spr_camera_down,0, 544, 700);

/*var _settingX = 32, _settingY = 32, _settingSprite = spr_gear;
if mouse_check_button_released(mb_left) {
	if point_in_rectangle(_mx, _my, _settingX, _settingY, _settingX+sprite_get_width(_settingSprite), _settingY+sprite_get_height(_settingSprite)) {
		if !(paused) {
			paused = true;
			audio_stop_all();
			global.chimeSound = audio_play_sound(chimes_2, 1, false);
			alarm[1] = 60*5;
		}
	}
}*/

#region settings UI
/*var _settingX = 32, _settingY = 32, _settingSprite = spr_gear;
	var _settingAlpha = 0;
	// Mute button posit
	if point_in_rectangle(_mx, _my, _settingX, _settingY, _settingX+sprite_get_width(_settingSprite), _settingY+sprite_get_height(_settingSprite)) {
		_settingAlpha = 1;
		if device_mouse_check_button_released(0, mb_left) {
			settingsUIEnabled = !settingsUIEnabled;
		}
	} 
	
	draw_sprite_ext(_settingSprite,	current_time*image_speed_get(spr_static), _settingX, _settingY, 1, 1, 0, c_white, _settingAlpha);
	
if (settingsUIEnabled) {
	
	// Draw UI
	draw_sprite_ext(spr_ui, 0, 456, 196, 19.42532, 21.247, 0, c_white, 1);
	
	// Temp slider
	var _sliderLeftX = 660, _sliderRightX = 764, _sliderButtonY = 240, _sliderButtonYIncr = 44, _sliderButtonWidth = 32; 
	var _sliderLeftXFix = _sliderLeftX-16, _sliderRightXFix = _sliderRightX-16, _sliderButtonYFix = _sliderButtonY-16;
	
	// Left Side
	draw_sprite_ext(spr_arrow, 0, _sliderLeftX, _sliderButtonY,					       1, 1, 180, c_white, 1);
	draw_sprite_ext(spr_arrow, 0, _sliderLeftX, _sliderButtonY + (_sliderButtonYIncr*1), 1, 1, 180, c_white, 1);
	draw_sprite_ext(spr_arrow, 0, _sliderLeftX, _sliderButtonY + (_sliderButtonYIncr*2), 1, 1, 180, c_white, 1);
	
	// Right Side			   	  
	draw_sprite_ext(spr_arrow, 0, _sliderRightX, _sliderButtonY,							1, 1, 0, c_white, 1);
	draw_sprite_ext(spr_arrow, 0, _sliderRightX, _sliderButtonY + (_sliderButtonYIncr*1), 1, 1, 0, c_white, 1);
	draw_sprite_ext(spr_arrow, 0, _sliderRightX, _sliderButtonY + (_sliderButtonYIncr*2), 1, 1, 0, c_white, 1);
	
	// UI Text
	draw_text(456+8, 196+8, FNAF_VERSION);
	draw_text(_sliderLeftX-160, _sliderButtonY, "Ambience");
	draw_text(_sliderLeftX-160, _sliderButtonY + (_sliderButtonYIncr*1), "Animatronics");
	draw_text(_sliderLeftX-160, _sliderButtonY + (_sliderButtonYIncr*2), "UI");
	
	// Text Boxes
	draw_set_valign(fa_center);
	draw_sprite_ext(spr_ui, 0, 680, 224, 3.666667, 2.066667, 0, c_white, 1);
	draw_sprite_ext(spr_ui, 0, 680, 268, 3.666667, 2.066667, 0, c_white, 1);
	draw_sprite_ext(spr_ui, 0, 680, 312, 3.666667, 2.066667, 0, c_white, 1);
	
	// Text
	var _c = c_black;
	draw_text_colour(680+7, 224+14, string(clamp(round(game_settings.volume_ambient * 100), 0, 100)) + "%",		_c, _c, _c, _c, 1);
	draw_text_colour(680+7, 268+14, string(clamp(round(game_settings.volume_animatronics * 100), 0, 100)) + "%",	_c, _c, _c, _c, 1);
	draw_text_colour(680+7, 312+14, string(clamp(round(game_settings.volume_ui * 100), 0, 100)) + "%",			_c, _c, _c, _c, 1);
	
	
	if (arrowSelected) {
		if (arrowTimer > 0) {
			arrowTimer--;	
		}
	}
	
	// Buttons
	var _incr = .01;
	var _oldAmbient = game_settings.volume_ambient, _oldAnimatronic = game_settings.volume_animatronics, _oldUI = game_settings.volume_ui;
	
	// Ambient
	if (point_in_rectangle(_mx, _my, _sliderLeftXFix, _sliderButtonYFix, _sliderLeftXFix + _sliderButtonWidth, _sliderButtonYFix + _sliderButtonWidth)) {
		//show_debug_message("E Left");
		if device_mouse_check_button(0, mb_left) {
			if !(arrowSelected) {
				arrowSelected = true;
				arrowTimer = 10;
				_oldAmbient -= _incr;
			} else if (arrowTimer <= 0) {
				arrowTimer = 10;	
				_oldAmbient -= _incr;
			}
		} else arrowSelected = false;	
	}
	
	if (point_in_rectangle(_mx, _my, _sliderRightXFix, _sliderButtonYFix, _sliderRightXFix + _sliderButtonWidth, _sliderButtonYFix + _sliderButtonWidth)) {
		//show_debug_message("E Right");
		if device_mouse_check_button(0, mb_left) {
			if !(arrowSelected) {
				arrowSelected = true;
				arrowTimer = 10;
				_oldAmbient += _incr;
			} else if (arrowTimer <= 0) {
				arrowTimer = 10;	
				_oldAmbient += _incr;
			}
		} else arrowSelected = false;	
	}
	
	// Animatronics
	if (point_in_rectangle(_mx, _my, _sliderLeftXFix, _sliderButtonYFix + (_sliderButtonYIncr*1), _sliderLeftXFix + _sliderButtonWidth, _sliderButtonYFix + _sliderButtonWidth + (_sliderButtonYIncr*1))) {
		//show_debug_message("A Left");
		if device_mouse_check_button(0, mb_left) {
			if !(arrowSelected) {
				arrowSelected = true;
				arrowTimer = 10;
				_oldAnimatronic -= _incr;
			} else if (arrowTimer <= 0) {
				arrowTimer = 10;	
				_oldAnimatronic -= _incr;
			}
		} else arrowSelected = false;	
	}

	if (point_in_rectangle(_mx, _my, _sliderRightXFix - 16, _sliderButtonYFix + (_sliderButtonYIncr*1), _sliderRightXFix + _sliderButtonWidth, _sliderButtonYFix + _sliderButtonWidth + (_sliderButtonYIncr*1))) {
		//show_debug_message("A Right");
		if device_mouse_check_button(0, mb_left) {
			if !(arrowSelected) {
				arrowSelected = true;
				arrowTimer = 10;
				_oldAnimatronic += _incr;
			} else if (arrowTimer <= 0) {
				arrowTimer = 10;	
				_oldAnimatronic += _incr;
			}
		} else arrowSelected = false;	
	}
	
		// Ui
	if (point_in_rectangle(_mx, _my, _sliderLeftXFix, _sliderButtonYFix + (_sliderButtonYIncr*2), _sliderLeftXFix + _sliderButtonWidth, _sliderButtonYFix + _sliderButtonWidth + (_sliderButtonYIncr*2))) {
		//show_debug_message("Games Left");
		if device_mouse_check_button(0, mb_left) {
			if !(arrowSelected) {
				arrowSelected = true;
				arrowTimer = 10;
				_oldUI -= _incr;
			} else if (arrowTimer <= 0) {
				arrowTimer = 10;	
				_oldUI -= _incr;
			}
		} else arrowSelected = false;	
	}
	
	if (point_in_rectangle(_mx, _my, _sliderRightXFix, _sliderButtonYFix + (_sliderButtonYIncr*2), _sliderRightXFix + _sliderButtonWidth, _sliderButtonYFix + _sliderButtonWidth + (_sliderButtonYIncr*2))) {
		//show_debug_message("Games Right");
		if device_mouse_check_button(0, mb_left) {
			if !(arrowSelected) {
				arrowSelected = true;
				arrowTimer = 10;
				_oldUI += _incr;
			} else if (arrowTimer <= 0) {
				arrowTimer = 10;	
				_oldUI += _incr;
			}
		} else arrowSelected = false;
	}
	
	// Clamp Volume
	_oldAmbient = clamp(_oldAmbient,0, 100);
	_oldAnimatronic = clamp(_oldAnimatronic,0, 100);
	_oldUI = clamp(_oldUI,0, 100);
	
	if (_oldAmbient != game_settings.volume_ambient || _oldAnimatronic != game_settings.volume_animatronics || _oldUI != game_settings.volume_ui) {
		update_game_settings(game_settings.volume_enabled, game_settings.last_location, _oldAmbient, _oldAnimatronic, _oldUI);
		save_settings();
		
		// Loop between all
		var _array = tag_get_asset_ids("Ambient", asset_sound);
		show_debug_message(_array);
		for(var _i = 0; _i < array_length(_array); ++_i) {
			if (audio_is_playing(_i)) {
				audio_sound_gain(_i, _oldAmbient, 0);	
			}
		}
		
		var _array = tag_get_asset_ids("UI", asset_sound);
		show_debug_message(_array);
		for(var _i = 0; _i < array_length(_array); ++_i) {
			if (audio_is_playing(_i)) {
				audio_sound_gain(_i, _oldUI, 0);	
			}
		}
		var _array = tag_get_asset_ids("Animatronic", asset_sound);
		show_debug_message(_array);
		for(var _i = 0; _i < array_length(_array); ++_i) {
			if (audio_is_playing(_i)) {
				audio_sound_gain(_i, _oldAnimatronic, 0);	
			}
		}
		
		audioSwitchKitchen();
		audioSwitchPirate();
	}	
	#endregion
	
	// Draw Mute Button
	var _muteX = 464, _muteY = 476, _muteSprite = spr_mute_call;
	draw_sprite_ext(_muteSprite,	current_time, _muteX, _muteY, 1, 1, 0, c_white, 1);
	if point_in_rectangle(_mx, _my, _muteX, _muteY, _muteX+sprite_get_width(_muteSprite), _muteY+sprite_get_height(_muteSprite))  && device_mouse_check_button_released(0, mb_left) {
		audio_set_master_gain(0, !audio_get_master_gain(0));	
		update_game_settings(audio_get_master_gain(0), currentCamera.location_name);
		save_settings();
	}
}*/
#endregion 
// Camera Buttons
for(var _i = 0; _i < array_length(cams); ++_i) {
	var _cam = cams[_i];
	if _cam.selected {
		if (--_cam.selectedVisualTimer) <= 0 {
			_cam.selectedVisualTimer = 30;
			_cam.selectedVisual = !_cam.selectedVisual;
		}
	}
	
	if (_cam.point_in_rect()) {
			if device_mouse_check_button_released(0, mb_left) {
				if audio_sound_is_playable(blip3) {
					if !audio_is_playing(blip3) {
						var _index = audio_play_sound(blip3, 0, false);
						audio_sound_gain(_index, game_settings.volume_ui, 0);
						global.currentAudio.blipClick = _index;
				}
			}
			if(currentCamera != _cam) {
				cameraChangeFlicker();
				currentCamera = _cam;
				backSprite = _cam.scene;
				sceneSwitch();
				update_game_settings(audio_get_master_gain(0), currentCamera.location_name);
			}
			
			if (_cam.randomAudioChange != -1) {
				if (irandom(1000) == 0) {
					var _index = audio_play_sound(_cam.randomAudioChange, 0, false);	
					audio_sound_gain(_index, .6*game_settings.volume_ui, 0);
					global.currentAudio.cameraChange = _index;
				}
			}
			for(var _ii = 0; _ii < array_length(cams); ++_ii) {
				cams[_ii].selected = false;	
			}
			
			_cam.selected = true;
		}
	}
	
	_cam.render();
}

// Draw Recording dot
if (round(sin(current_time/500))) {
	draw_sprite(spr_recording, 0, 64, 48);
}

draw_set_font(numFontTime);
if (paused) {
	var _five = string_height("5");
	if (audio_sound_get_track_position(global.chimeSound) >= 3) && (textUp <= _five) {
		textUp += .2;	
	}
	draw_set_alpha(-1*alpha);
	var _str = "5\n6";
	var _offsetX = 72;
	var _x = display_get_gui_width() / 2;
	var _y = display_get_gui_height() / 2;
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_text(_x-_offsetX, _y-textUp, _str);
	draw_sprite(spr_am, 0, _x-_offsetX + string_width(_str) + 12, _y-_five);
	if (alpha >= -.99 && (alpha <= 0)) {
		draw_set_alpha(1);	
	}
	draw_set_colour(c_black);
	draw_rectangle(_x-_offsetX,_y-(_five), _x-_offsetX+string_width(_str), 0, false);
	draw_rectangle(_x-_offsetX,_y, _x-_offsetX+string_width(_str), 1024, false);
	draw_set_colour(c_white);
}
draw_set_valign(fa_top);

draw_set_alpha(1);	

/*draw_text(32,32,animatronics.Foxy);
draw_text(32,64,foxyAnimateRun);
draw_text(32,96,visitedFoxyRun);*/

//draw_circle(_mx, _my, 32, false);

if (creditsAlpha > 0) {
	draw_set_font(fnt_text);
	draw_set_alpha(creditsAlpha);
	var _str = "Created by TabularElf - "
	var _str2 = "https://tabelf.link/";
	draw_text(24, 24, _str);
	draw_set_colour(c_aqua);
	draw_text(24+string_width(_str), 24, _str2);
	/*if (mouse_check_button_released(mb_left)) {
		if point_in_rectangle(_mx, _my, 24 + string_width(_str), 24, string_width(_str2) + string_width(_str) + 24, 24 + string_height(_str2)) {
			url_open("https://tabelf.link");	
		}
	}*/
	draw_set_colour(c_white);
	draw_text_transformed(24 + string_width(_str) + string_width(_str2), 24 + 7, " (Join the Discord for more FNAF content!)", .5, .5, 0);
	draw_set_alpha(1);
	draw_set_halign(fa_left);
}