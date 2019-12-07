package better;

/*
	Created at: 13 February 2019
	[Description]
 */
final class StringFuncs {
	public static inline function isEmpty(str:String):Bool {
		return str.length == 0;
	}

	public static inline function isNotEmpty(str:String):Bool {
		return str.length > 0;
	}
}
