package com.reycogames.powerhour.data
{
	import starling.textures.Texture;

	public class EmbeddedAssets
	{
		[Embed(source="/../assets/images/powerhour/splash_logo.fw.png")]
		private static const SPLASH_LOGO_EMBEDDED:Class;
		public static var SPLASH_LOGO:Texture;
		
		[Embed(source="/../assets/images/powerhour/large_cup.fw.png")]
		private static const LARGE_CUP_EMBEDDED:Class;
		public static var LARGE_CUP:Texture;
		
		[Embed(source="/../assets/fonts/ARIAL.TTF",fontName="Arial",mimeType="application/x-font",embedAsCFF="false")]
		public static const ARIAL_REGULAR:Class;
		
		[Embed(source="/../assets/fonts/ARIBLK.TTF",fontName="Arial Black",mimeType="application/x-font",embedAsCFF="false")]
		public static const ARIAL_BLACK:Class;
		
		public static function initialize():void
		{
			SPLASH_LOGO = Texture.fromBitmap( new SPLASH_LOGO_EMBEDDED() );
			LARGE_CUP = Texture.fromBitmap( new LARGE_CUP_EMBEDDED() );
		}
	}
}