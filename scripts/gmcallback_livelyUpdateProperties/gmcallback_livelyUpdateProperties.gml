function gmcallback_livelyUpdateProperties(){
	var _key = LivelyGetKey(), _value = LivelyGetValue();
	livelyUpdateProperties(_key, _value);
}