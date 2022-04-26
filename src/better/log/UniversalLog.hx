package better.log;

import haxe.PosInfos;

using better.StringBufExtensions;
using Lambda;

class UniversalLog extends Log {
	final onLineAdded:Null<(String)->Void>;

	public function new(?onLineAdded:(String)->Void) {
		this.onLineAdded = onLineAdded;
	}

	public function attachTrace():Void {
		haxe.Log.trace = (v, ?infos) -> {
			final i = '{${infos.className}:(${infos.methodName}:${infos.lineNumber})}';
			#if debug
			log('$i => $v', Debug, FgMagenta);
			#end
		};
	}

	public function info(...v:Any):Void
		log(stringify(v), Info, FgWhite);

	public function warning(...v:Any):Void
		log(stringify(v), Warn, FgYellow);

	public function error(...v:Any):Void
		log(stringify(v), Error, FgRed);

	public function critical(...v:Any):Void
		log(stringify(v), Critical, BgRed | FgWhite);

	public function success(...v:Any):Void
		log(stringify(v), Success, FgGreen);

	public function debug(...v:Any):Void {
		#if debug
		log(stringify(v), Debug, FgMagenta);
		#end
	}

	function log(str:String, level:Loglevel, style:Style, ?infos:PosInfos):Void {
		final out = '$style[$level] $str${Style.Reset}';
		#if js
			final c = #if nodejs js.Node.console; #else js.Browser.console; #end
			c.log(out);
		#elseif cpp
			#if (ios || macos)
			cpp.objc.NSLog.log(cpp.objc.NSString.fromString(out));
			#else
			cpp.Lib.println(out);
			#end
		#elseif java
			#if android
				switch loglevel {
					case Warn:
						untyped __java__('android.util.Log.w("[{0}]", {1})', level, out);
					case Debug:
						untyped __java__('android.util.Log.d("[{0}]", {1})', level, out);
					case Error, Critical:
						untyped __java__('android.util.Log.e("[{0}]", {1})', level, out);
					default:
						untyped __java__('android.util.Log.i("[{0}]", {1})', level, out);
				}
			#else
			java.Lib.println(out);
			#end
		#elseif lua
			untyped __define_feature__("use._hx_print", _hx_print(str));
		#else
			#if sys
			Sys.println(out);
			#end
		#end

		if (onLineAdded != null) {
			onLineAdded(out);
		}
	}

	inline function stringify(items:Array<Any>):String
		return items.map(v -> haxe.Json.stringify(v)).join(', ');
}

private enum abstract Loglevel(String) to String {
	var Verbose = "VERB";
	var Debug = "DEBG";
	var Info = "INFO";
	var Warn = "WARN";
	var Error = "ERRR";
	var Critical = "CRIT";
	var Success = "SCSS";
}


private enum abstract Style(String) to String from String {
	var Reset = "\x1b[0m";
	var Bright = "\x1b[1m";
	var Dim = "\x1b[2m";
	var Underscore = "\x1b[4m";
	var Blink = "\x1b[5m";
	var Reverse = "\x1b[7m";
	var Hidden = "\x1b[8m";
	var FgBlack = "\x1b[30m";
	var FgRed = "\x1b[31m";
	var FgGreen = "\x1b[32m";
	var FgYellow = "\x1b[33m";
	var FgBlue = "\x1b[34m";
	var FgMagenta = "\x1b[35m";
	var FgCyan = "\x1b[36m";
	var FgWhite = "\x1b[37m";
	var BgBlack = "\x1b[40m";
	var BgRed = "\x1b[41m";
	var BgGreen = "\x1b[42m";
	var BgYellow = "\x1b[43m";
	var BgBlue = "\x1b[44m";
	var BgMagenta = "\x1b[45m";
	var BgCyan = "\x1b[46m";
	var BgWhite = "\x1b[47m";

	@:op(A | B)
	function connect(a:Style):Style
		return '$this$a';
}
