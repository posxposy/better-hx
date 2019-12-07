import utest.ui.Report;
import utest.Runner;
import tests.*;

final class Main {
	public static function main():Void {
		final runner = new Runner();
		runner.addCase(new StringFuncTests());
		runner.addCase(new ArrayFuncTests());
		final report = Report.create(runner);
		runner.run();
	}
}