package better;

@:publicFields
final class FloatExtensions {
	/**
		Round float number to selected precision
		@param precision
		@return Float
	 */
	static inline function fixed(v:Float, precision:Int):Float {
		return Math.round(v * Math.pow(10, precision)) / Math.pow(10, precision);
	}

	/**
	 * Syntax sugar for Math.floor(v)
	 * @param v
	 * @return Int
	 */
	static inline function floor(v:Float):Int {
		return Math.floor(v);
	}

	/**
	 * Syntax sugar for Math.ceil(v)
	 * @param v
	 * @return Int
	 */
	static inline function ceil(v:Float):Int {
		return Math.ceil(v);
	}

	/**
	 * Syntax sugar for Math.abs(v)
	 * @param v
	 * @return Float
	 */
	static inline function abs(v:Float):Float {
		return Math.abs(v);
	}

	/**
	 * Round float number to selected precision and convert it to String
	 * @param v
	 * @param precision
	 * @return String
	 */
	static inline function toStringAsFixed(v:Float, precision:Int):String {
		return Std.string(fixed(v, precision));
	}

	/**
	 * Returns `true` if value is between the two values
	 * @param first
	 * @param second
	 * @return Bool
	 */
	static inline function isBetween(v:Float, first:Float, second:Float):Bool {
		final lower = Math.min(first, second);
		final upper = Math.max(first, second);
		return v > lower && v < upper;
	}
}
