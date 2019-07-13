package better.hx;
import haxe.PosInfos;

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

	public static function getHistory():String {
		return history.join("");
	}

	public static function setup():Void {
		haxe.Log.trace = info;
	}

	/**
		Attach default Haxe trace function to the current Logf.info();
	 */
	public static function assign():Void {
		haxe.Log.trace = info;
	}

	/**
		Verbose. Use it for additional messages.
		@param value - any value
	 */
	public static function verbose(value:Dynamic, decor:TextColor = FG_WHITE, ?pos:PosInfos):Void {
		log(value, Loglevel.VERBOSE, decor, pos);
	}

	/**
		Debug. Works only with `debug` compilation flag.
		@param value
		@param decor
	 */
	public static function debug(value:Dynamic, decor:TextColor = FG_CYAN, ?pos:PosInfos):Void {
		#if debug
		log(value, Loglevel.DEBUG, decor, pos);
		#end
	}

	/**
		Regular informational message
		@param value - any value
	 */
	public static function info(value:Dynamic, ?pos:PosInfos):Void {
		log(value, Loglevel.INFO, TextColor.FG_WHITE, pos);
	}

	/**
		Warning message.
		@param value - any value
	 */
	public static function warn(value:Dynamic, decor:TextColor = FG_YELLOW, ?pos:PosInfos):Void {
		log(value, Loglevel.WARN, decor, pos);
	}

	/**
		Error message.
		@param value - any value
	 */
	public static function error(value:Dynamic, decor:TextColor = FG_RED, ?pos:PosInfos):Void {
		log(value, Loglevel.ERROR, decor, pos);
	}

	/**
		Critical message.
		@param value - any value
	 */
	public static function critical(value:Dynamic, decor:TextColor = TextColor.BG_RED, ?pos:PosInfos):Void {
		if (decor == TextColor.BG_RED) {
			decor |= TextColor.FG_WHITE;
		}
		log(value, Loglevel.CRITICAL, decor, pos);
	}

	/**
		Success message
		@param value - any value
	 */
	public static function success(value:Dynamic, decor:TextColor = TextColor.FG_GREEN, ?pos:PosInfos):Void {
		log(value, Loglevel.SUCCESS, decor, pos);
	}

	/**
		Implementation.
		@param value - any value
	 */
	inline static function log(value:Dynamic, loglevel:Loglevel, decor:TextColor, ?pos:PosInfos):Void {
		final valueStr:String = Std.string(value);
		final scheme:String = '[$loglevel][${pos.className}]';
		var methodInfo:String = "";
		var customParams:String = "";
		if (pos.customParams != null) {
			for (v in pos.customParams) {
				customParams += ", " + Std.string(v);
			}
		}

		methodInfo = '${pos.methodName}:${pos.lineNumber}';
		#if js
		final console = #if nodejs js.Node.console; #else js.Browser.console; #end
		console.log('$decor$scheme > $methodInfo > $valueStr${TextColor.RESET}');
		#elseif cpp
			#if ios
			cpp.objc.NSLog.log(cpp.objc.NSString.fromString('[$loglevel]$out'));
			#else
			throw "Not implemented.";
			#end
		#elseif java
			#if android
			switch loglevel {
				case Warn: {
						android.util.Log.w('[$loglevel]', out);
					}
				case Debug: {
						android.util.Log.d('[$loglevel]', out);
					}
				case Error, Critical: {
						android.util.Log.e('[$loglevel]', out);
					}
				default: {
						android.util.Log.i('[$loglevel]', out);
					}
			}
			#end
		#else
			throw "Not implemented.";
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
		final date:Date = Date.now();
		final result:String = '
			<strong>${date.toString()} > $scheme > $methodInfo<br>
				$value
			</strong>
		';
		switch loglevel {
			case INFO: {
					history.push('
						<div class="card-body text-muted link text-monospace">
							${date.toString()} > $scheme<br>
							$value$customParams
						</div>
					');
				}
			case WARN: {
					history.push('
						<div class="border-left border-warning card-body text-warning text-monospace">
							$result
						</div>
					');
				}
			case DEBUG: {
					history.push('
						<div class="border-left border-info card-body text-info text-monospace">
							$result
						</div>
					');
				}
			case VERBOSE: {
					history.push('
						<div class="card-body text-dark text-monospace">
							$result
						</div>
					');
				}
			case CRITICAL: {
					history.push('
						<div class="border-left border-danger card-body text-white bg-danger text-monospace">
							$result
						</div>
					');
				}
			case ERROR: {
					history.push('
						<div class="border-left border-danger card-body text-danger text-monospace">
							$result
						</div>
					');
				}
			case SUCCESS: {
					history.push('
						<div class="border-left border-success card-body text-success text-monospace">
							$result
						</div>
					');
				}
		}
	}
}


private enum abstract Loglevel(String) to String {
	var VERBOSE = "VERB";
	var DEBUG = "DEBG";
	var INFO = "INFO";
	var WARN = "WARN";
	var ERROR = "ERRR";
	var CRITICAL = "CRIT";
	var SUCCESS = "SCSS";
}
