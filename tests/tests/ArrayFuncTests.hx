package tests;

import utest.Assert;
import utest.Test;
using better.ArrayExtensions;

final class ArrayFuncTests extends Test {
	function test_clear():Void {
		final a:Array<Int> = [1, 2, 3, 4, 5];
		a.clear();
		Assert.equals(a.length, 0);
	}

	function test_getFirst():Void {
		final a:Array<Int> = [1, 2, 3, 4, 5];
		Assert.equals(a.first(), 1);
	}

	function test_getLast():Void {
		final a:Array<Int> = [1, 2, 3, 4, 5];
		Assert.equals(a.last(), 5);
	}

	function test_get():Void {
		final a:Array<Int> = [1, 2, 3, 4, 5];
		Assert.equals(a.get(2), 3);
	}

	function test_isEmpty():Void {
		final a1:Array<Int> = [];
		final a2:Array<Int> = [1, 2, 3];
		Assert.isTrue(a1.isEmpty() && !a2.isEmpty());
	}

	function test_isNotEmpty():Void {
		final a1:Array<Int> = [];
		final a2:Array<Int> = [1, 2, 3];
		Assert.isTrue(!a1.isNotEmpty() && a2.isNotEmpty());
	}

	function test_fill():Void {
		final a:Array<Int> = [];
		a.fill(1, 3);
		Assert.same(a, [1, 1, 1]);
	}
}