package better;

import haxe.PosInfos;

/**
	Result is a wrapper type which can be `Success` and contain optional data in it
	or `Failure` and contain failure message.
	It is similar to `haxe.ds.Optional`.
 */
enum Result<TData, TFailure> {
	Success(data:TData);
	Failure(failure:TFailure);
}
