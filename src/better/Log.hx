package better;

import haxe.PosInfos;

using better.StringBufFuncs;

enum abstract TextColor(String) to String from String {
	var RESET = "\x1b[0m";
	var BRIGHT = "\x1b[1m";
	var DIM = "\x1b[2m";
	var UNDERSCORE = "\x1b[4m";
	var BLINK = "\x1b[5m";
	var REVERSE = "\x1b[7m";
	var HIDDEN = "\x1b[8m";
	var FG_BLACK = "\x1b[30m";
	var FG_RED = "\x1b[31m";
	var FG_GREEN = "\x1b[32m";
	var FG_YELLOW = "\x1b[33m";
	var FG_BLUE = "\x1b[34m";
	var FG_MAGENTA = "\x1b[35m";
	var FG_CYAN = "\x1b[36m";
	var FG_WHITE = "\x1b[37m";
	var BG_BLACK = "\x1b[40m";
	var BG_RED = "\x1b[41m";
	var BG_GREEN = "\x1b[42m";
	var BG_YELLOW = "\x1b[43m";
	var BG_BLUE = "\x1b[44m";
	var BG_MAGENTA = "\x1b[45m";
	var BG_CYAN = "\x1b[46m";
	var BG_WHITE = "\x1b[47m";

	@:op(A | B)
	function connect(a:TextColor):TextColor {
		return '$this$a';
	}
}

class Log {
	static var history(default, never):Array<String> = [];

	public static function toHTML():String {
		final buf = new StringBuf();
		buf.addLine('<!doctype html>');
		buf.addLine('<html lang="en">');
		buf.addLine('<head>');
		buf.addLine('<meta charset="utf-8">');
		buf.addLine('<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">');
		buf.addLine('<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous">');
		buf.addLine('<title>App logs</title>');
		buf.addLine('</head>');
		buf.addLine('<body style="margin:15px;">');
		buf.addLine('<div class="container">');
		buf.addLine('<h3>Server logs</h3><br>');
		buf.addLine(history.join(""));
		buf.addLine('</div>');
		buf.addLine('<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>');
		buf.addLine('<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>');
		buf.addLine('<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>');
		buf.addLine('</body>');
		buf.addLine('</html>');
		return buf.toString();
	}

	/**
		Attach default Haxe trace function to the current Log.info();
	 */
	public static function assignTraceToInfo():Void {
		haxe.Log.trace = info;
	}

	/**
		Verbose. Use it for additional messages.
		@param value - any value
	 */
	public static function verbose(value:Dynamic, decor:TextColor = FG_WHITE, ?pos:PosInfos):Void {
		log(value, Verbose, decor, pos);
	}

	/**
		Debug. Works only with `debug` compilation flag.
		@param value
		@param decor
	 */
	public static function debug(value:Dynamic, decor:TextColor = FG_CYAN, ?pos:PosInfos):Void {
		#if debug
		log(value, Debug, decor, pos);
		#end
	}

	/**
		Regular informational message
		@param value - any value
	 */
	public static function info(value:Dynamic, ?pos:PosInfos):Void {
		log(value, Info, TextColor.FG_WHITE, pos);
	}

	/**
		Warning message.
		@param value - any value
	 */
	public static function warn(value:Dynamic, decor:TextColor = FG_YELLOW, ?pos:PosInfos):Void {
		log(value, Warn, decor, pos);
	}

	/**
		Error message.
		@param value - any value
	 */
	public static function error(value:Dynamic, decor:TextColor = FG_RED, ?pos:PosInfos):Void {
		log(value, Error, decor, pos);
	}

	/**
		Critical message.
		@param value - any value
	 */
	public static function critical(value:Dynamic, decor:TextColor = TextColor.BG_RED, ?pos:PosInfos):Void {
		if (decor == TextColor.BG_RED) {
			decor |= TextColor.FG_WHITE;
		}
		log(value, Critical, decor, pos);
	}

	/**
		Success message
		@param value - any value
	 */
	public static function success(value:Dynamic, decor:TextColor = TextColor.FG_GREEN, ?pos:PosInfos):Void {
		log(value, Success, decor, pos);
	}

	/**
		Implementation.
		@param value - any value
	 */
	inline static function log(value:Dynamic, loglevel:Loglevel, decor:TextColor, ?pos:PosInfos):Void {
		final valueStr = Std.string(value);
		final scheme:String = '[$loglevel][${pos.className}]';
		var methodInfo = '${pos.methodName}:${pos.lineNumber}';
		var customParams = "";
		if (pos.customParams != null) {
			for (v in pos.customParams) {
				customParams += ", " + Std.string(v);
			}
		}

		final out = '$scheme > $methodInfo > $valueStr';
		#if js
		final c = #if nodejs js.Node.console; #else js.Browser.console; #end
		c.log('$decor$out${TextColor.RESET}');
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
				untyped __java__('android.util.Log.w("[{0}]", {1})', scheme, out);
			case Debug:
				untyped __java__('android.util.Log.d("[{0}]", {1})', scheme, out);
			case Error, Critical:
				untyped __java__('android.util.Log.e("[{0}]", {1})', scheme, out);
			default:
				untyped __java__('android.util.Log.i("[{0}]", {1})', scheme, out);
		}
		#else
		java.Lib.println(out);
		#end
		#elseif lua
		untyped __define_feature__("use._hx_print", _hx_print(str));
		#else
		#if sys
		Sys.println(out);
		#else
		throw "Not implemented.";
		#end
		#end

		writeHistory(scheme, methodInfo, valueStr, customParams, loglevel);
	}

	/**
		Write history in HTML way
		@param scheme -
		@param methodInfo -
		@param value -
		@param loglevel -
	 */
	static inline function writeHistory(scheme:String, methodInfo:String, value:String, customParams:String, loglevel:Loglevel):Void {
		final date = Date.now();
		final result = '
			<strong>${date.toString()} > $scheme > $methodInfo<br>
				$value
			</strong>
		';
		switch loglevel {
			case Info:
				history.push('
					<div class="card-body text-muted link text-monospace">
						${date.toString()} > $scheme<br>
						$value$customParams
					</div>
				');
			case Warn:
				history.push('
					<div class="border-left border-warning card-body text-warning text-monospace">
						$result
					</div>
				');
			case Debug:
				history.push('
					<div class="border-left border-info card-body text-info text-monospace">
						$result
					</div>
				');
			case Verbose:
				history.push('
					<div class="card-body text-dark text-monospace">
						$result
					</div>
				');
			case Critical:
				history.push('
					<div class="border-left border-danger card-body text-white bg-danger text-monospace">
						$result
					</div>
				');
			case Error:
				history.push('
					<div class="border-left border-danger card-body text-danger text-monospace">
						$result
					</div>
				');
			case Success:
				history.push('
					<div class="border-left border-success card-body text-success text-monospace">
						$result
					</div>
				');
		}
	}
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
