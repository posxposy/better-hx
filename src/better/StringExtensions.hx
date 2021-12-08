package better;

import haxe.Json;
import haxe.io.Encoding;

@:publicFields
final class StringExtensions{
	static inline function isEmpty(value:String):Bool {
		return value.length == 0;
	}

	static inline function isNotEmpty(value:String):Bool {
		return value.length > 0;
	}

	static inline function parseJson(value:String):Any {
		return Json.parse(value);
	}
}
