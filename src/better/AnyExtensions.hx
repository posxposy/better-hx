package better;

using Reflect;

@:publicFields
final class AnyExtensions {
	static function hasFields(v:Dynamic, ...fields:String):Bool {
		for (fieldName in fields) {
			if (!v.hasField(fieldName)) {
				return false;
			}
		}
		return true;
	}
}