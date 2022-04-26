package better.log;

abstract class Log {
	abstract public function info(...v:Any):Void;
	abstract public function debug(...v:Any):Void;
	abstract public function warning(...v:Any):Void;
	abstract public function error(...v:Any):Void;
	abstract public function critical(...v:Any):Void;
	abstract public function success(...v:Any):Void;
}
