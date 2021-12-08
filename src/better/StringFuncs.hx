package better;

@:publicFields
final class StringFuncs {
	static inline function isEmpty(value:String):Bool {
		return value.length == 0;
	}

	static inline function isNotEmpty(value:String):Bool {
		return value.length > 0;
	}
}
