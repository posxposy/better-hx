package better.sys;

import haxe.io.Path;
import sys.io.File;
import sys.FileSystem;

using StringTools;

class FileSystemFuncs {
	public static function copyDirRecursively(cl:Class<FileSystem>, from:String, to:String):Void {
		final entries:Array<String> = FileSystem.readDirectory(from);
		for (entry in entries) {
			if (FileSystem.isDirectory('$from/$entry')) {
				FileSystem.createDirectory('$to/$entry');
				copyDirRecursively(cl, '$from/$entry', '$to/$entry');
			} else {
				File.copy('$from/$entry', '$to/$entry');
			}
		}
	}
}
