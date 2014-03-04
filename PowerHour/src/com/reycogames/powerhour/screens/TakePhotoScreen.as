package com.reycogames.powerhour.screens
{
	import com.reycogames.powerhour.controls.ImageButton;
	import com.reycogames.powerhour.model.AppModel;
	import com.reycogames.powerhour.model.AppScreens;
	import com.reycogames.powerhour.screens.core.AbstractScreen;
	
	import feathers.controls.LayoutGroup;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.VerticalLayout;
	
	public class TakePhotoScreen extends AbstractScreen
	{
		private var container:LayoutGroup;
		private var containerLayout:VerticalLayout;
		private var takePhotoButton:ImageButton;
		private var skipPhotoButton:ImageButton;
		
		public function TakePhotoScreen()
		{
			super( "TAKE THE PHOTO ;)" );
		}
		
		override protected function initializeHandler():void
		{
			super.initializeHandler();
			
			containerLayout = new VerticalLayout();
			containerLayout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			containerLayout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_MIDDLE;
			containerLayout.gap = 150;
			
			container = new LayoutGroup();
			container.layout = containerLayout;
			container.layoutData = new AnchorLayoutData(0, 0, 0, 0);
			addChild( container );
			
			takePhotoButton = new ImageButton("take_photo_button.fw", stage.stageWidth * 0.80);
			container.addChild( takePhotoButton );
			
			skipPhotoButton = new ImageButton("skip_photo_button.fw", stage.stageWidth * 0.80);
			skipPhotoButton.onTrigger = gotoCountdownScreen;
			container.addChild( skipPhotoButton );
		}
		
		private function gotoCountdownScreen():void
		{
			AppModel.navigator.showScreen( AppScreens.COUNTDOWN_SCREEN );
		}
	}
}