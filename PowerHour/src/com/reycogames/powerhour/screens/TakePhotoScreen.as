package com.reycogames.powerhour.screens
{
	import com.reycogames.powerhour.controls.TakePictureButton;
	import com.reycogames.powerhour.manager.CameraManager;
	import com.reycogames.powerhour.model.AppModel;
	import com.reycogames.powerhour.model.AppScreens;
	import com.reycogames.powerhour.screens.core.AbstractScreen;
	
	import feathers.controls.LayoutGroup;
	import feathers.layout.AnchorLayoutData;
	
	public class TakePhotoScreen extends AbstractScreen
	{
		private var takePictureButton:TakePictureButton;
		private var container:LayoutGroup;
		
		public function TakePhotoScreen()
		{
			super("SHOOT!");
		}
		
		override protected function initializeHandler():void
		{
			super.initializeHandler();
			
			container = new LayoutGroup();
			container.layoutData = new AnchorLayoutData(0, 0, 0, 0);
			addChild( container );		
			
			takePictureButton = new TakePictureButton();
			takePictureButton.onTrigger = takePhoto;
			container.addChild( takePictureButton );
			
			CameraManager.startVideoCapture();
			container.addChild( CameraManager.getVideo() );
		}
		
		private function takePhoto():void
		{
			AppModel.assetManager.getSound("shutterSound").play();
			captureImageData()
		}
		
		protected function captureImageData():void
		{
			CameraManager.stopVideoCapture();
			AppModel.navigator.showScreen( AppScreens.CONFIRM_SNAPSHOT_SCREEN );
		}
		
		override protected function draw():void
		{
			super.draw();
			container.validate();
			takePictureButton.y = container.height - takePictureButton.height;
			
			CameraManager.height = takePictureButton.y;
		}
		
		override public function dispose():void
		{
			super.dispose();
			CameraManager.dispose();
		}
	}
}