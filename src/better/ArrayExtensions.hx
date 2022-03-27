package better;

@:publicFields
final class ArrayExtensions {
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

	static inline function max<T:Float>(a:Array<T>):T {
		var result:T = a[0];
		for (i in 1...a.length) {
			final value = a[i];
			if (value > result) {
				result = value;
			}
		}
		return result;
	}

	static inline function min<T:Float>(a:Array<T>):T {
		var result:T = a[0];
		for (i in 1...a.length) {
			final value = a[i];
			if (value < result) {
				result = value;
			}
		}
		return result;
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

	/**
	 * Creates an array of elements split into groups the length of size. If array can't be split evenly, the final chunk will be the remaining elements.
	 * @param a The array to process
	 * @param size The length of each chunk
	 * @return Returns the new array of chunks `Array<Array<T>>` .
	 */
	static function chunk<T>(a:Array<T>, size:Int):Array<Array<T>> {
		var chunksCount = Math.round(a.length / size);
		var chunks:Array<Array<T>> = [];

		var offset = 0;
		for (_ in 0...chunksCount) {
			var chunk:Array<T> = [];
			for (i in 0...size) {
				var idx = i + offset;
				if (idx < a.length) {
					chunk.push(a[i + offset]);
				}
			}
			offset += size;
			chunks.push(chunk);
		}

		return chunks;
	}
}
