package better;

@:publicFields
final class ArrayFuncs {
	static inline function clear<T>(a:Array<T>):Void {
		while (a.length > 0) {
			a.pop();
		}
	}

	static inline function first<T>(a:Array<T>):T {
		return a[0];
	}

	static inline function last<T>(a:Array<T>):T {
		return a[a.length - 1];
	}

	static inline function get<T>(a:Array<T>, index:Int):T {
		return a[index];
	}

	static inline function isEmpty<T>(a:Array<T>):Bool {
		return a.length == 0;
	}

	static inline function isNotEmpty<T>(a:Array<T>):Bool {
		return a.length != 0;
	}

	static function fill<T>(a:Array<T>, value:T, ?length:Int):Array<T> {
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
