package tests;

import utest.Assert;
import utest.Test;

using better.FloatExtensions;

final class FloatTests extends Test {
	function test_fixed():Void {
		final value = 0.123456789;
		Assert.floatEquals(0.12, value.fixed(2));
	}

	function test_toStringAsFixed():Void {
		final value = 0.123456789;
		Assert.equals('0.12', value.toStringAsFixed(2));
	}

	function test_isBetween():Void {
		final value = 12.34;
		Assert.isTrue(value.isBetween(10, 20));
	}
}