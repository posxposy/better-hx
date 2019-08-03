package better;

class StringBufFuncs {
	public static inline function addLine(buf:StringBuf, line:String, indents:Int = 0):Void {
		for (i in 0...indents) {
			buf.add("\t");
		}
		buf.add('$line\n');
	}

	public static inline function addEmptyLine(buf:StringBuf):Void {
		buf.add('\n');
	}
}
