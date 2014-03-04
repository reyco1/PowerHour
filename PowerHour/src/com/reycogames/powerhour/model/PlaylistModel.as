package com.reycogames.powerhour.model
{
	import com.reycogames.powerhour.manager.FileManager;
	
	import flash.filesystem.File;

	public class PlaylistModel
	{
		public  static var initialized:Boolean   	= false;
		public  static var playlistObject:Object 	= null;
		public  static var playlists:Array			= null;
		
		public static function loadData():void
		{
			if(!initialized)
			{							
				playlistObject = FileManager.readObjectFromFile( "playlists.phd" );	
								
				if(playlistObject == null)
				{
					playlists = [];
					playlistObject = {playlists:playlists};
					FileManager.writeObjectToFile( playlistObject, "playlists.phd" );
				}
				else
				{
					playlists = playlistObject.playlists
				}
				
				initialized = true;
			}
		}
		
		public static function saveData():void
		{
			FileManager.writeObjectToFile( playlistObject, "playlists.phd" );
		}
		
		public static function addPlaylist( playlistName:String ):void
		{
			var playlistItem:Object = { title:playlistName, tracks:[] };
			playlistObject.playlists.push( playlistItem );
			saveData();
		}
		
		public static function deletePlaylist( playlistName:String ):void
		{
			for (var a:int = 0; a < playlists.length; a++) 
			{
				if(playlists[a].title == playlistName)
				{
					playlists.splice(a, 1);
					break;
				}
			}
			saveData();
		}
		
		public static function addTrack( playlistName:String, trackName:String, trackFile:String, autoSave:Boolean = true ):void
		{
			var list:Object = getPlaylistByName( playlistName );
			var fileName:String = getFileName( trackName );
			list.tracks.push( {name:fileName, file:trackFile} );
			if(autoSave)
				saveData();
		}
		
		public static function deleteTrack( playlistName:String, trackName:String ):void
		{
			var list:Object = getPlaylistByName( playlistName );
			for (var a:int = 0; a < list.tracks.length; a++) 
			{
				if(list.tracks[a].name == trackName)
				{
					list.tracks.splice( a, 1 );
					break;
				}
			}
			saveData();
		}
		
		private static function getPlaylistByName( playlistName:String ):Object
		{
			for (var a:int = 0; a < playlists.length; a++) 
			{
				if(playlists[a].title == playlistName)
				{
					return playlists[a];
				}
			}
			return null;
		}
		
		private static function getFileName( path:String ):String
		{
			var fileName:String = "";
			var parts:Array = path.split( File.separator );
			fileName = parts[ parts.length - 1 ].split( "." )[0];
			return fileName;
		}
	}
}