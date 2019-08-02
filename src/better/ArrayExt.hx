package;

/*
	Created at: 13 February 2019
	[Description]
 */
class ArrayFuncs {
	public static inline function clear<T>(a:Array<T>):Void {
		while (a.length > 0) {
			a.pop();
		}
	}
}
