/// @description Cat Judges your code
/* 
    |\__/,|   (`\
  _.|o o  |_   ) )
-(((---(((--------
Cat Judges your code
*/

global.width = 1;
global.height = 1;
numFontTime = font_add_sprite_ext(spr_fontNumbersTime, "0123456789", true, 2);
numFontNights = font_add_sprite_ext(spr_fontNumbersNights, "0123456789", true, 2);
date_set_timezone(timezone_local);

global.currentAudio = {
		foxyRunning: -1,
		freddyLaugh: -1,
		blipClick: -1,
		buzzFan: -1,
		VCRSFX: -1,
		normalRunningLeft: -1,
		normalRunningRight: -1,
		cameraChange: -1,
		pirateSong: -1,
		kitchenSong: -1,
		kitchenPans: -1,
		knocking: -1,
		eerieAmbience: -1,
		hallucinations: -1,
		garbled: -1,
};

randomize();
function moveAnimatronic(_animatronic) {
			var _lastLocation = _animatronic.location;
			switch(_animatronic) {
			case animatronics.Bonnie: 
				switch(_animatronic.location) {
					case locations.Stage:
						_animatronic.location = locations.PartyRoom;
					break;
					
					case locations.PartyRoom:
						if (_animatronic.subPos > 0) {
							_animatronic.location = locations.Backstage;	
							_animatronic.subPos = 0;
						} else {
							++ _animatronic.subPos;	
						}
					break;
					
					case locations.Backstage:
							_animatronic.location = locations.HallwayLeftA;	
					break;
					
					case locations.HallwayLeftA:
						_animatronic.location = locations.Closet;
					break;
					
					case locations.Closet:
						_animatronic.location = locations.HallwayLeftB;
					break;
					
					case locations.HallwayLeftB:
						if (irandom(3) != 0) {
							_animatronic.location = locations.PartyRoom;
							var _index = audio_play_sound(snd_running_fast3, 0, false);
							audio_sound_gain(_index, .5*game_settings.volume_animatronics, 0);
							global.currentAudio.normalRunningLeft = _index;
						} else {
							_animatronic.location = locations.HallwayLeftA;	
						}
					break;
				}
				if (currentCamera.location == _lastLocation) || (currentCamera.location == _animatronic.location) {
					cameraChangeFlicker();
					animatronicMovedChange();
					sceneSwitch();
				}
			break;
			
			case animatronics.Chica:
				switch(animatronics.Chica.location) {
					case locations.Stage:
						_animatronic.location = locations.PartyRoom;
					break;
					
					case locations.PartyRoom:
						if (_animatronic.subPos > 0) {
							_animatronic.location = locations.Restrooms;	
							_animatronic.subPos = 0;
						} else {
							++ _animatronic.subPos;	
						}
					break;
					
					case locations.Restrooms:
						if (_animatronic.subPos > 0) {
							_animatronic.location = locations.Kitchen;	
							_animatronic.subPos = 0;
						} else {
							++ _animatronic.subPos;	
						}
					break;
					
					case locations.Kitchen:
						_animatronic.location = locations.HallwayRightA;
					break;
					
					case locations.HallwayRightA:
						if (_animatronic.subPos > 0) {
							_animatronic.location = locations.HallwayRightB;	
							_animatronic.subPos = 0;
						} else {
							++ _animatronic.subPos;	
						}
					break;
					
					case locations.HallwayRightB:
					if (irandom(3) != 0) {
						_animatronic.location = locations.PartyRoom;
						var _index = audio_play_sound(snd_running_fast3, 0, false);
						audio_sound_gain(_index, .5*game_settings.volume_animatronics, 0);
						global.currentAudio.normalRunningRight = _index;
					} else {
						_animatronic.location = locations.HallwayRightA;
					}
					break;
				}
				
				if (currentCamera.location == _lastLocation) || (currentCamera.location == _animatronic.location) {
					cameraChangeFlicker();
					animatronicMovedChange();
					sceneSwitch();
				}
			break;
			
			case animatronics.Freddy:
			// Make sure that both Bonnie and Chica are gone, so we don't move Freddy while they're both on stage.
			//Thanks to missing textures.
				if (animatronics.Bonnie.location == locations.Stage) {
					if (animatronics.Chica.location == locations.Stage) {
						randomize();
						moveAnimatronic(choose(animatronics.Bonnie, animatronics.Chica));	
					} else {
						moveAnimatronic(animatronics.Bonnie);	
					}
				} else if animatronics.Chica.location == locations.Stage {
					moveAnimatronic(animatronics.Chica);
				} else {
					if currentCamera.location != _animatronic.location {
						if (audio_is_playing(snd_Laugh_Giggle_Girl_1d) || audio_is_playing(snd_Laugh_Giggle_Girl_2d) || audio_is_playing(snd_Laugh_Giggle_Girl_8d)) {
							audio_stop_sound(snd_Laugh_Giggle_Girl_1d);
							audio_stop_sound(snd_Laugh_Giggle_Girl_2d);
							audio_stop_sound(snd_Laugh_Giggle_Girl_8d);
						}
						
						var _laugh = choose(snd_Laugh_Giggle_Girl_1d, snd_Laugh_Giggle_Girl_2d, snd_Laugh_Giggle_Girl_8d);
						if audio_sound_is_playable(_laugh) {
							var _index = audio_play_sound(_laugh, 0, false);
							audio_sound_gain(_laugh, .5*game_settings.volume_animatronics, 0);
							global.currentAudio.freddyLaugh = _index;
						}
						
						switch(_animatronic.location) {
							case locations.Stage:
								_animatronic.location = locations.PartyRoom;
							break;	
							
							case locations.PartyRoom:
								_animatronic.location = locations.Restrooms;
							break;
							
							case locations.Restrooms:
								_animatronic.location = locations.Kitchen;
							break;
							
							case locations.Kitchen:
								_animatronic.location = locations.HallwayRightA;
							break;
							
							case locations.HallwayRightA:
								_animatronic.location = locations.HallwayRightB;
							break;
							
							case locations.HallwayRightB:
								_animatronic.location = locations.PartyRoom;
								var _index = audio_play_sound(snd_running_fast3, 0, false);
								audio_sound_gain(_index, .5*game_settings.volume_animatronics, 0);
								global.currentAudio.normalRunningRight = _index;
							break;
						}
					
					if (currentCamera.location == _lastLocation) || (currentCamera.location == _animatronic.location) {
						cameraChangeFlicker();
						animatronicMovedChange();
						sceneSwitch();
					}
					}
				}
			break;
		}
	/*if (_animatronic.pos >= array_length(_animatronic.locationsAllowed)-1) {
		_animatronic.pos = _animatronic.isFoxy == true ? 0 : 1;
	} else {
		++_animatronic.pos;	
	}
	
	_animatronic.location = _animatronic.locationsAllowed[_animatronic.pos];*/
}

function cam_create(_location, _x, _y, _tx, _ty, _sprite, _scene, _spr_cam_loc_name) constructor {
	x = _x;
	y = _y;
	location = _location;
	tx = _tx;
	ty = _ty;
	sprite = !is_undefined(_sprite) ? _sprite : spr_cam_1a;
	spr_cam_loc_name = is_undefined(_spr_cam_loc_name) ? spr_blank : _spr_cam_loc_name;
	scene = !is_undefined(_scene) ? _scene : spr_party_room;
	width = x + sprite_get_width(spr_cam_loc_border);
	height = y + sprite_get_height(spr_cam_loc_border);
	selected = false;
	selectedVisualTimer = 30;
	selectedVisual = false;
	disabled = false;
	randomAudioChange = -1;
	
	static point_in_rect = function() {
		return point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), x, y, width, height);	
	}
	
	static render = function() {
		draw_sprite(spr_cam_loc_border, (selected == true) && (selectedVisual == true) ? 1 : 0, x, y);
		draw_sprite(sprite, 0, tx, ty);
			if (selected) && (disabled) { 
				draw_sprite(spr_cam_disabled, 0, 656, 64);
			}
		if (selected) draw_sprite(spr_cam_loc_name, 0, 972, 320);
	}
}

enum locations {
	Stage,
	PirateCove,
	PartyRoom,
	Backstage,
	HallwayLeftA,
	HallwayLeftB,
	HallwayRightA,
	HallwayRightB,
	Restrooms,
	Kitchen,
	Closet
}

enum characters {
	Freddy,
	Bonnie,
	Chica,
	Foxy,
	Length
}

function animatronic_create(_location, _isFoxy, _locationsAllowed) constructor {
	location = _location;
	isFoxy = is_undefined(_isFoxy) ? false : _isFoxy;
	foxyStage = 0;
	locationsAllowed = is_undefined(_locationsAllowed) ? [locations.Stage] : _locationsAllowed;
	//locationFrames = _locationFrames;
	pos = 0;
	subPos = 0;
}

/*var _foxyFrames = [[0,1,2,3],[]];
for(var _i = 0; _i < sprite_get_number(spr_foxy_run); ++_i) {
	_foxyFrames[1][_i] = _i;	
}*/

game_settings = {};
init_game_settings();
update_game_settings(true, "STAGE", .5, .5, .5);

if (file_exists("settings.txt")) {
	var _buff = buffer_load("settings.txt");
	var _string = buffer_read(_buff, buffer_string);
	var _oldSettings = json_parse(_string);
	buffer_delete(_buff);
	
	if (is_struct(_oldSettings)) {
		if (_oldSettings.version != WALLPAPER_VERSION) {
			var _keys = variable_struct_get_names(game_settings);
			
			for(var _i = 0; _i < array_length(_keys); ++_i) {
				if (_oldSettings[$ _keys[_i]] == undefined) {
					_oldSettings[$ _keys[_i]] = game_settings[$ _keys[_i]];
				}
			}
			_oldSettings.version = WALLPAPER_VERSION;
		} 
		game_settings = _oldSettings;	
	}
} 
audio_set_master_gain(0, game_settings.volume_enabled);	

knob1Selected = false;
knob2Selected = false;
knob3Selected = false;

settingsUIEnabled = false;
arrowTimer = 0;
arrowSelected = false;

draw_set_font(fnt_text);

animatronics = {
	Freddy: new animatronic_create(locations.Stage, false, [locations.Stage, locations.Restrooms, locations.Kitchen, locations.HallwayRightA, locations.HallwayRightB]),
	Bonnie: new animatronic_create(locations.Stage, [locations.Stage, locations.Backstage, locations.HallwayLeftA, locations.Closet, locations.HallwayLeftB]),
	Chica: new animatronic_create(locations.Stage, false, [locations.Stage, locations.Restrooms, locations.Kitchen, locations.HallwayRightA, locations.HallwayRightB]),
	Foxy: new animatronic_create(locations.PirateCove, true, [locations.PirateCove])
}

/*locationOccupants = {
	Stage: [],
	PirateCove: [],
	PartyRoom: [],
	HallwayLeftA: [],
	HallwayLeftB: [],
	HallwayRightA: [],
	HallwayRightB: [],
	HallwayLeftA: [],
	Restrooms: [],
}*/

randomMoveTimer = 240;

static_timer = 0;
static_timer_min = 30;
static_timer_max = 60;

//show_debug_message(animatronics);


application_surface_draw_enable(false);

flip = true;
halt = false;
view_camera[0] = camera_create_view(0,0,1280,720);
display_set_gui_size(1280,720);

muteAlpha = .02;
oldMuteAlpha = .02;
newMuteAlpha = .02;
backSprite = spr_stage;
backIndex = 0;
//alarm[1] = irandom_range(480, 1800);
cameraChange = false;
cameraChangeIndex = 0;
randomHallucinationsNum = 0;
randomHallucinationsNumTimer = 5;
randomHallucinations = 0;
global.animatronicsHaveMoved = false;