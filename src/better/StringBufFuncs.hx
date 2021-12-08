package better;

@:publicFields
class StringBufFuncs {
	static inline function addLine(buf:StringBuf, line:String, indents:Int = 0):Void {
		for (_ in 0...indents) {
			buf.add("\t");
		}
		buf.add('$line\n');
	}

	static inline function addEmptyLine(buf:StringBuf):Void {
		buf.add('\n');
	}
}
