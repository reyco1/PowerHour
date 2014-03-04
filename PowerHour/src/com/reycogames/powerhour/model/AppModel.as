package com.reycogames.powerhour.model
{
	import com.reycogames.powerhour.data.Playlist;
	import com.reycogames.powerhour.manager.ScreenManager;
	import com.reycogames.powerhour.screens.core.ScreenNavigatorWithHistory;
	
	import flash.media.Sound;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	import flash.media.SoundChannel;

	public class AppModel
	{
		public static const DISTRIQT_DEV_KEY:String = "8f21f85cfd46ab4b3ba61c8d11df7128efe8aeb7L5vzz3LOlLqZOtBZZl2yj6KduZ6PGqYzGVz1apHKT9V9rFNdAZ0GwXYNVRjpb1Mfxn33/G8jDZX26v5r3fLa0A==";
		
		private static var textureAtlas:TextureAtlas;
		
		public static var LOW_RES:Boolean;
		public static var assetManager:AssetManager;
		public static var navigator:ScreenNavigatorWithHistory;
		public static var MINUTES:int = 60;
		public static var selectedPlaylist:Playlist;
		public static var screenManager:ScreenManager;
		public static var playlistSetForEdit:Object;
		public static var tracksToAdd:Array;
		
		public static var CURRENT_SONG:Sound;
		public static var CURRENT_SONG_INDEX:int;
		public static var CURRENT_SONG_SOUNDCHANNEL:SoundChannel;
				
		public static function getTexture( name:String ):Texture
		{
			if(!textureAtlas)
				textureAtlas = AppModel.assetManager.getTextureAtlas( "powerhour" );	
			
			return textureAtlas.getTexture( name );
		}
	}
}