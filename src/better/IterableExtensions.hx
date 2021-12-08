package better;

@:publicFields
final class IterableExtensions {
	static inline function where<T>(it:Iterable<T>, test:(e:T) -> Bool):Array<T> {
		return inline Lambda.filter(it, test);
	}
}
