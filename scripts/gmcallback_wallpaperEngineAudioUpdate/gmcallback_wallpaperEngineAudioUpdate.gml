global.__wallpaperEngineAudioData = [];

function gmcallback_wallpaperEngineAudioUpdate() {
	global.__wallpaperEngineAudioData = wallpaperEngineAudioGet();
}