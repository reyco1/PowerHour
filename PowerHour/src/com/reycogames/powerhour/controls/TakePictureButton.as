package com.reycogames.powerhour.controls
{
	import com.reycogames.powerhour.model.AppColors;
	import com.reycogames.powerhour.model.AppModel;
	
	import feathers.controls.ImageLoader;
	
	import starling.display.Quad;
	import starling.events.Event;

	public class TakePictureButton extends ComplexButton
	{
		private var background:Quad;
		private var image:ImageLoader;
		
		public function TakePictureButton()
		{
			super();
		}
		
		override protected function initializeHandler(event:Event):void
		{
			super.initializeHandler(event);
			
			background = new Quad( stage.stageWidth, stage.stageHeight * 0.1, AppColors.RED_ORANGE );
			addChild( background );
			
			image = new ImageLoader();
			image.maintainAspectRatio = true;
			image.source = AppModel.assetManager.getTexture( "snap_pic_button.fw" );
			image.width = stage.stageWidth * 0.8;
			addChild( image );
			
			image.validate();
			
			image.x = ( background.width  - image.width )  * 0.5;
			image.y = ( background.height - image.height ) * 0.5;
		}
	}
}