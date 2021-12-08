package tests;

import utest.Assert;
import utest.Test;
using better.IterableExtensions;

final class IterableTests extends Test{
	function test_where():Void {
		final a:Array<Int> = [1, 2, 2, 4, 5];
		final r1 = a.where((e) -> e == 2);
		final r2= a.where((e) -> e == 6);

		Assert.equals(r1.length, 2);
		Assert.equals(r2.length, 0);
	}
}