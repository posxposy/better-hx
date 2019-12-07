package better;

/*
	Created at: 13 February 2019
	[Description]
 */
final class ArrayFuncs {
	public static inline function clear<T>(a:Array<T>):Void {
		while (a.length > 0) {
			a.pop();
		}
	}

	public static inline function getFirst<T>(a:Array<T>):T {
		return a[0];
	}

	public static inline function getLast<T>(a:Array<T>):T {
		return a[a.length - 1];
	}

	public static inline function get<T>(a:Array<T>, index:Int):T {
		return a[index];
	}

	public static inline function isEmpty<T>(a:Array<T>):Bool {
		return a.length == 0;
	}

	public static function fill<T>(a:Array<T>, value:T, ?length:Int):Array<T> {
		final l:Int = if (length == null) {
			a.length;
		} else {
			var l = Std.int(Math.abs(length));
			if (l < a.length) {
				l = a.length;
			}
			l;
		}
		for (i in 0...l) {
			a[i] = value;
		}
		return a;
	}
}
