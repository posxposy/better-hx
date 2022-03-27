package tests;

import utest.Assert;
import utest.Test;

using better.StringExtensions;

final class StringTests extends Test {
	function test_IsEmpty():Void {
		final str1 = "";
		final str2 = "test";
		Assert.isTrue(str1.isEmpty() && !str2.isEmpty());
	}

	function test_IsNotEmpty():Void {
		final str1 = "";
		final str2 = "test";
		Assert.isTrue(!str1.isNotEmpty() && str2.isNotEmpty());
	}

	function test_parseJson():Void {
		final obj:{hello:String} = '{"hello":"World"}'.parseJson();
		Assert.equals(obj.hello, "World");
	}

	function test_upperFirst():Void {
		final str = 'hello';
		Assert.equals('Hello', str.upperFirst());
	}
}
