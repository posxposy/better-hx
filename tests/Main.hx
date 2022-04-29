import utest.ui.Report;
import utest.Runner;
import tests.*;

final class Main {
	public static function main():Void {
		final runner = new Runner();
		runner.addCase(new StringTests());
		runner.addCase(new ArrayTests());
		runner.addCase(new IterableTests());
		runner.addCase(new FloatTests());
		runner.addCase(new AnyTests());
		final report = Report.create(runner);
		runner.run();
	}
}
