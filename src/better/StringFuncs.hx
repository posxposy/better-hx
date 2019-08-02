package better;

/*
	Created at: 13 February 2019
	[Description]
 */
class StringFuncs {
	public static inline function isValid(str:Null<String>, ?invalidLength:Int = 0):Bool {
		return str != null && str.length != 0;
	}
}
