package better;

@:publicFields
final class IterableExtensions {
	static inline function where<T>(it:Iterable<T>, test:(e:T) -> Bool):Array<T> {
		return inline Lambda.filter(it, test);
	}

	static inline function firstWhere<T>(it:Iterable<T>, test:(e:T) -> Bool):Null<T> {
		var result:Null<T> = null;
		for (e in it) {
			if (test(e)) {
				result = e;
				break;
			}
		}
		return result;
	}

	static inline function lastWhere<T>(it:Iterable<T>, test:(e:T) -> Bool):Null<T> {
		var result:Null<T> = null;
		for (e in it) {
			if (test(e)) {
				result = e;
			}
		}
		return result;
	}
}
