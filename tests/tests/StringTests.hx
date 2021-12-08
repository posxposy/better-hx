package tests;

import utest.Assert;
import utest.Test;
using better.StringExtensions;

final class StringTests extends Test {
	public function test_IsEmpty() {
		final str1 = "";
		final str2 = "test";
		Assert.isTrue(str1.isEmpty() && !str2.isEmpty());
	}

	public function test_IsNotEmpty() {
		final str1 = "";
		final str2 = "test";
		Assert.isTrue(!str1.isNotEmpty() && str2.isNotEmpty());
	}

	public function test_parseJson() {
		final obj:{hello:String} = '{"hello":"World"}'.parseJson();
		Assert.equals(obj.hello, "World");
	}
}