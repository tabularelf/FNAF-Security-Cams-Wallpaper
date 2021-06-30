/// @description Cat Judges your code
/* 
    |\__/,|   (`\
  _.|o o  |_   ) )
-(((---(((--------
Cat Judges your code
*/
/// mouse camera movement

/*if (randomMoveTimer > 0) {
	--randomMoveTimer;	
}

if (randomMoveTimer == 0) {
	var _char = irandom(characters.Length-1);
	switch(_char) {
		case characters.Freddy:
			if (animatronics.Bonnie.location == locations.Stage) {
				if (animatronics.Chica.location == locations.Stage) {	
					moveAnimatronic(choose(animatronics.Bonnie,animatronics.Chica));	
				} else {
					moveAnimatronic(animatronics.Chica);		
				}
			} else if (animatronics.Chica.location == locations.Stage) {	
				moveAnimatronic(animatronics.Chica);
			}	
		break;
	}
	
	randomMoveTimer = 10*60;
}*/

//var _map = audio_get_listener_info(0);

//show_debug_message(json_encode(_map));

//ds_map_destroy(_map);

/*var _masterAudioPitch = audio_get_master_gain(0);

if !window_has_focus() {
	if game_settings.volume_enabled {
		audio_master_gain(lerp(_masterAudioPitch,0,.05));	
	} 
} else {
	if game_settings.volume_enabled {
		audio_master_gain(lerp(_masterAudioPitch,1,.05));	
	}
}*/

if (static_timer == 0) {
	
	if (cameraChange) {
		cameraChangeIndex += image_speed_get(spr_vhs_change);
		if (cameraChangeIndex > sprite_get_number(spr_vhs_change)) {
			cameraChange = false;
			cameraChangeIndex = 0;
		}
	}
	
	if (os_browser != browser_not_a_browser) {
		surface_resize(application_surface,display_get_width(), display_get_height());
		window_set_size(display_get_width(), display_get_height());
	}
	
	if audio_sound_is_playable(Buzz_Fan_Florescent2) {
		if !audio_is_playing(Buzz_Fan_Florescent2) {
			var _index = audio_play_sound(Buzz_Fan_Florescent2, 0, false);
			audio_sound_gain(_index, .3*game_settings.volume_ambient, 0);
		}
	}
	
	if audio_sound_is_playable(MiniDV_Tape_Eject_1) {
		if !audio_is_playing(MiniDV_Tape_Eject_1) {
			var _index = audio_play_sound(MiniDV_Tape_Eject_1, 0, false);
			audio_sound_gain(_index, game_settings.volume_ui, 0);
		}
	}
	
	// Animatronic moving
	#region Foxy goes first
	if (irandom(6000) == 0) {
		if (currentCamera.location != locations.PirateCove) {
			if (animatronics.Foxy.foxyStage != 3) && !(visitedFoxyRun) {
				++animatronics.Foxy.foxyStage;	
			} 
		}
	}
	
	if (currentCamera.location == locations.HallwayLeftA) {
		if (animatronics.Foxy.foxyStage == 3) && (foxyAnimateRun < sprite_get_number(spr_foxy_run)-1) && (visitedFoxyRun) {
			foxyAnimateRun += image_speed_get(spr_foxy_run);
			backIndex = foxyAnimateRun;	
			if !(audio_is_playing(snd_run)) {
				var _index = audio_play_sound(snd_run,0, false);	
				audio_sound_gain(_index, .6*game_settings.volume_animatronics, 0);
			}
		} 
	} else {
		if (animatronics.Foxy.foxyStage == 3) {
			if (irandom(2000) == 0) {
				if !audio_is_playing(snd_knock2) {
					var _index = audio_play_sound(snd_knock2, 0, false);	
					audio_sound_gain(_index, game_settings.volume_animatronics, 0);
				}	
				resetFoxy();
				sceneSwitch();
				if (currentCamera.location == locations.PirateCove) {
					cameraChangeFlicker();	
				}
			}
		}
	}
	
	if (foxyAnimateRun == sprite_get_number(spr_foxy_run)-1) {
		resetFoxy();
		if !audio_is_playing(snd_knock2) {
			audio_play_sound(snd_knock2, 0, false);	
			audio_sound_gain(_index, game_settings.volume_animatronics, 0);
		}
	}
	
	// Foxy singing Timer
	if (irandom(4800) == 0) {
		if (animatronics.Foxy.foxyStage == 0) {
			if !(audio_is_playing(snd_pirate_song)) {
				var _index = audio_play_sound(snd_pirate_song, 0, false);
				audioSwitchPirate();
			}
		}
	}
	#endregion
	
	#region Bonnie/Chica/Freddy Move
		if (irandom(1800) == 0) {
			moveAnimatronic(animatronics.Bonnie);
		}
		
		if (irandom(1600) == 0) {
			moveAnimatronic(animatronics.Chica);
		}
		
		if (irandom(2400) == 0) {
			moveAnimatronic(animatronics.Freddy);	
		}
		
		if (animatronics.Chica.location == locations.Kitchen) {
			if (irandom(120) == 0) {
				if !(audio_is_playing(snd_OVEN_DRA_1_GEN_HDF18119) || audio_is_playing(snd_OVEN_DRA_2_GEN_HDF18120)	 || audio_is_playing(snd_OVEN_DRA_7_GEN_HDF18121) || audio_is_playing(snd_OVEN_DRAWE_GEN_HDF18122)) {
					audio_play_sound(choose(snd_OVEN_DRA_1_GEN_HDF18119, snd_OVEN_DRA_2_GEN_HDF18120, snd_OVEN_DRA_7_GEN_HDF18121, snd_OVEN_DRAWE_GEN_HDF18122), 0, false);
					audioSwitchKitchen();
				}
		} 
			
			if (irandom(1200) == 0) {
				if !(audio_is_playing(snd_music_box) || audio_is_playing(snd_circius)) {
					audio_play_sound(snd_circius, 0, false);
					audioSwitchKitchen();
				}
			}
		} else {
				audio_stop_sounds(snd_OVEN_DRA_1_GEN_HDF18119, snd_OVEN_DRA_2_GEN_HDF18120, snd_OVEN_DRA_7_GEN_HDF18121, snd_OVEN_DRAWE_GEN_HDF18122, snd_circius);	
		}
		
		if (animatronics.Freddy.location == locations.Kitchen) {
			if (irandom(2400) == 0) {
				if !(audio_is_playing(snd_music_box) || audio_is_playing(snd_circius)) {
					audio_play_sound(snd_music_box, 0, false);
					audioSwitchKitchen();
				}
			}	
		} else {
			audio_stop_sound(snd_music_box);	
		}
		
		
	#endregion
	
	// move the view when mouse reaches the edge.
	if (!halt) {
		#macro INCR .8
		
		//view_xview[0] = lerp(view_xview[0], clamp(abs(sin(current_time / 5000)*(view_wview[0]/5)),0, room_width-(view_wview[0]/12)), .25);
		var _view = view_camera[0];
		var _xview = camera_get_view_x(_view);
		var _wview = camera_get_view_width(_view);
		
		if (flip) {
				if (_xview < (room_width-_wview)) {camera_set_view_pos(_view, _xview+INCR, 0);} else {flip = false; halt = true; alarm[0] = 60;}
			} else {
			    if (_xview > 0) {camera_set_view_pos(_view, _xview-INCR, 0);} else {flip = true; halt = true; alarm[0] = 60;}
			}
		}
} else {
	--static_timer;	
}
//window_set_fullscreen(true);*/