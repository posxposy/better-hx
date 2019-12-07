package tests;

import utest.Assert;
import utest.Test;
using better.StringFuncs;

final class StringFuncTests extends Test {
	public function test_IsEmpty() {
		final str1:String = "";
		final str2:String = "test";
		Assert.isTrue(str1.isEmpty() && !str2.isEmpty());
	}

	public function test_IsNotEmpty() {
		final str1:String = "";
		final str2:String = "test";
		Assert.isTrue(!str1.isNotEmpty() && str2.isNotEmpty());
	}
}