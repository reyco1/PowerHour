package com.reycogames.powerhour.model
{
	import com.reycogames.powerhour.data.Playlist;
	import com.reycogames.powerhour.manager.ScreenManager;
	
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	import feathers.controls.ScreenNavigator;
	
	import starling.display.Stage;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;

	public class AppModel
	{
		public static const DISTRIQT_DEV_KEY:String 				= "8f21f85cfd46ab4b3ba61c8d11df7128efe8aeb7L5vzz3LOlLqZOtBZZl2yj6KduZ6PGqYzGVz1apHKT9V9rFNdAZ0GwXYNVRjpb1Mfxn33/G8jDZX26v5r3fLa0A==";
		public static const FACEBOOK_APP_ID:String 					= "1508178179410893";
		
		private static var textureAtlas:TextureAtlas				= null;
		
		public static var LOW_RES:Boolean							= false;
		public static var IS_IOS:Boolean							= false;
		public static var assetManager:AssetManager					= null;
		public static var navigator:ScreenNavigator					= null;
		public static var selectedPlaylist:Playlist					= null;
		public static var screenManager:ScreenManager				= null;
		public static var playlistSetForEdit:Object					= null;
		public static var tracksToAdd:Array							= null;
		
		public static var CURRENT_SONG:Sound						= null;
		public static var CURRENT_SONG_INDEX:int					= 0;
		public static var CURRENT_SONG_SOUNDCHANNEL:SoundChannel	= null;
		public static var MINUTES:int 								= 60;
		public static var STARLING_SATGE:starling.display.Stage		= null;
		public static var processedImageData:Object					= {};		
				
		public static function getTexture( name:String ):Texture
		{
			if(!textureAtlas)
				textureAtlas = AppModel.assetManager.getTextureAtlas( "powerhour" );	
			
			return textureAtlas.getTexture( name );
		}
	}
}