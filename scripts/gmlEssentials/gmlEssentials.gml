function audio_stop_sounds() {
	for(var _i = 0; _i < argument_count; ++_i) {
		audio_stop_sound(argument[_i]);	
	}
}

function audio_stop_sound_array(_array) {
	for(var _i = 0; _i < array_length(_array); ++_i) {
		audio_stop_sound(_array[_i]);	
	}
}