package better;

import haxe.Json;

using StringTools;

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

	/**
	 * Converts the first character of string to upper case.
	 * @param str The string to convert.
	 * @return String
	 */
	 static inline function upperFirst(str:String):String {
		if (str.length == 0 || str.isSpace(0)) {
			return str;
		}

		if (str.length == 1) {
			return str.toUpperCase();
		}

		return str.charAt(0).toUpperCase() + str.substr(1);
	}
}
