package com.reycogames.powerhour.screens
{
	import com.reycogames.powerhour.controls.FinalScreenControls;
	import com.reycogames.powerhour.controls.ImageButton;
	import com.reycogames.powerhour.model.AppModel;
	import com.reycogames.powerhour.screens.core.AbstractScreen;
	
	import feathers.controls.ImageLoader;
	import feathers.controls.LayoutGroup;
	import feathers.layout.AnchorLayoutData;
	
	public class FinalScreen extends AbstractScreen
	{
		private var finalImage:ImageLoader;
		private var shareButton:ImageButton;
		private var playAgainButton:ImageButton;
		private var buttonContainer:LayoutGroup;
		private var finalUI:FinalScreenControls;
		private var container:LayoutGroup;
		public function FinalScreen()
		{
			super("Ahhhh!!!!");
		}
		
		override protected function initializeHandler():void
		{
			super.initializeHandler();
			
			container = new LayoutGroup();
			container.layoutData = new AnchorLayoutData(0, 0, 0, 0);
			addChild( container );
			
			finalImage = new ImageLoader();
			finalImage.maintainAspectRatio = true;
			finalImage.x = 10;
			finalImage.width = AppModel.STARLING_SATGE.stageWidth - 20;
			finalImage.source = AppModel.processedImageData.picture_url;
			container.addChild( finalImage );
			
			finalUI = new FinalScreenControls();
			container.addChild( finalUI );
		}
		
		override protected function draw():void
		{
			super.draw();
			
			finalImage.validate();
			finalImage.width = stage.stageWidth - 20;
			finalImage.x = 10;
			
			finalUI.validate();
			finalUI.y = container.height - finalUI.height;
		}
	}
}