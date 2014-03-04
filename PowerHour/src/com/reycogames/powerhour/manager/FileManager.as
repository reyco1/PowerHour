package com.reycogames.powerhour.manager
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	public class FileManager
	{
		public static function getDirectoryListing( directory:File ):Array
		{
			var listing:Array = [];
			var directoryListing:Array = directory.getDirectoryListing();
			for (var a:int = 0; a < directoryListing.length; a++) 
			{
				var file:File = directoryListing[a];
				if(!file.isHidden)
				{
					if(file.isDirectory || (file.extension && file.extension.indexOf("mp3") > -1))
					{
						listing.push( file );
					}
				}
			}
			
			return listing;
		}
		
		public static function getAllMp3Files():Array
		{
			var arr:Array = traverseFolderForFiles( File.getRootDirectories() );						
			return arr;
		}
		
		private static function traverseFolderForFiles(directories:Array):Array
		{
			var arr:Array = [];
			
			for (var a:int = 0; a < directories.length; a++) 
			{
				var directoryItems:Array = directories[a].getDirectoryListing();
				
				for (var b:int = 0; b < directoryItems.length; b++) 
				{
					var fileOrFolder:File = directoryItems[b];
					
					if(!fileOrFolder.isHidden)
					{
						if(!fileOrFolder.isDirectory)
						{
							if(fileOrFolder.extension && fileOrFolder.extension.indexOf("mp3") > -1 )
								arr.push( fileOrFolder );
						}
						else
						{
							arr.concat(traverseFolderForFiles( [ fileOrFolder ] ));
						}
					}
				}				
			}
			
			return null;
		}
		
		public static function writeObjectToFile(object:Object, fname:String):void
		{
			var file:File = File.applicationStorageDirectory.resolvePath(fname);			
			var fileStream:FileStream = new FileStream();
			
			try
			{
				fileStream.open(file, FileMode.WRITE);
				fileStream.writeUTFBytes( JSON.stringify(object) );
			} 
			catch(error:Error) 
			{
				trace( error.message );
			}
			finally
			{
				fileStream.close();
			}			
		}
		
		public static function readObjectFromFile(fname:String):Object
		{
			var file:File = File.applicationStorageDirectory.resolvePath(fname);
			
			if(file.exists) 
			{
				var obj:String;
				var fileStream:FileStream = new FileStream();
				
				try
				{
					fileStream.open(file, FileMode.READ);
					obj = fileStream.readUTFBytes( fileStream.bytesAvailable );
				} 
				catch(error:Error) 
				{
					trace( error.message );
				}
				finally
				{
					fileStream.close();
				}				
				
				return JSON.parse( obj );
			}
			
			return null;
		}
	}
}