package better;

import haxe.PosInfos;
import better.Log;

/**
	Result is a wrapper type which can be `Success` and contain optional data in it
	or `Failure` and contain failure message.
	It is similar to `haxe.ds.Optional`.
 */
@:using(Result.ResultExtensions)
enum Result<T> {
	Success(?data:T);
	Failure(errorMessage:String);
}

@:publicFields
class ResultExtensions {
	static inline function log<T>(resp:Result<T>, ?pos:PosInfos):Result<T> {
		switch (resp) {
			case Failure(msg):
				Log.error(msg, pos);
			case Success(data) if (data != null):
				Log.success(data);
			case _:
		};
		return resp;
	}
}
