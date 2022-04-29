package tests;

import utest.Assert;
import utest.Test;

using better.AnyExtensions;
final class AnyTests extends Test {
	function test_hasFields():Void {
		final o = {
			name: 'test',
			value: 123
		};

		final has = o.hasFields('name', 'value');
		final hasNot = !o.hasFields('name', 'test');
		Assert.isTrue(has && hasNot);
	}
}