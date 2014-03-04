package com.reycogames.powerhour.controls
{
	import com.reycogames.powerhour.data.EmbeddedAssets;
	import com.reycogames.powerhour.model.AppColors;
	import com.reycogames.powerhour.model.AppFonts;
	import com.reycogames.powerhour.model.AppModel;
	
	import feathers.controls.ImageLoader;
	import feathers.controls.LayoutGroup;
	import feathers.events.FeathersEventType;
	
	import starling.events.Event;
	import starling.textures.TextureSmoothing;
	
	public class CountDownCup extends LayoutGroup
	{
		private var logoImage:ImageLoader;
		private var timerlabel:CustomLabel;
				
		
		public function CountDownCup()
		{
			super();
			addEventListener( FeathersEventType.INITIALIZE, handleInitialize );
		}
		
		private function handleInitialize( event:Event ):void
		{
			logoImage = new ImageLoader();
			logoImage.smoothing = TextureSmoothing.BILINEAR;
			logoImage.source = EmbeddedAssets.LARGE_CUP;
			logoImage.maintainAspectRatio = true;
			logoImage.textureScale = 0.5;
			logoImage.width = stage.stageWidth * 0.75;
			addChild( logoImage );
			
			timerlabel = new CustomLabel( AppFonts.ARIAL_BLACK, AppColors.WHITE, AppModel.LOW_RES ? 80 : 100 );
			addChild( timerlabel );
			
			logoImage.validate();			
			timerlabel.validate();
		}
		
		public function set text(value:int):void
		{
			timerlabel.text = value + "s";
			
			logoImage.validate();			
			timerlabel.validate();
			
			timerlabel.x = ( logoImage.width  - timerlabel.width  ) * 0.5;
			timerlabel.y = ( logoImage.height - timerlabel.height ) * 0.5;
		}
	}
}