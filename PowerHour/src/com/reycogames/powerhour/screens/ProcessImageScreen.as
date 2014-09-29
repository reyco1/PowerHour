package com.reycogames.powerhour.screens
{
	import com.reycogames.powerhour.controls.CustomLabel;
	import com.reycogames.powerhour.manager.ImageGenerationManager;
	import com.reycogames.powerhour.manager.ImageUploadManager;
	import com.reycogames.powerhour.model.AppFonts;
	import com.reycogames.powerhour.model.AppModel;
	import com.reycogames.powerhour.model.AppScreens;
	import com.reycogames.powerhour.screens.processimaegscreen.ProgressComponent;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.utils.setTimeout;
	
	import feathers.controls.LayoutGroup;
	import feathers.controls.ScrollContainer;
	import feathers.core.PopUpManager;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.VerticalLayout;
	
	import starling.display.DisplayObject;
	
	public class ProcessImageScreen extends ScrollContainer
	{
		private var loader:URLLoader;
		private var container:LayoutGroup;
		private var imageProcessProgerss:ProgressComponent;
		private var labelClip:CustomLabel;
		
		public function ProcessImageScreen()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			var layoutData:AnchorLayoutData = new AnchorLayoutData();
			layoutData.horizontalCenter = 0;
			layoutData.verticalCenter = 0;
			
			var vLayout:VerticalLayout = new VerticalLayout();
			vLayout.gap = 25;
			
			container = new LayoutGroup();
			container.layoutData = layoutData;
			container.layout = vLayout;
			addChild( container );
			
			imageProcessProgerss = new ProgressComponent();
			container.addChild( imageProcessProgerss );
			
			imageProcessProgerss.label = "Doing image magic: ";
			imageProcessProgerss.percent = 0;
			
			ImageGenerationManager.onProgress = handleImageProcessProgress;
			ImageGenerationManager.onComplete = handleImageProcessComplete;
		}
		
		private function handleImageProcessComplete():void
		{
			labelClip = new CustomLabel(AppFonts.ARIAL_BLACK, 0xFFFFFF, 30);
			container.addChild( labelClip );
			labelClip.text = "Almost there...";
			
			ImageUploadManager.save( ImageGenerationManager.image_2, "end" );
			ImageUploadManager.onUploadComplete = handleUploadComplete;
			ImageUploadManager.onUploadFail = handleUploadFail;
		}
		
		private function handleUploadFail():void
		{
			labelClip = new CustomLabel(AppFonts.ARIAL_BLACK, 0xFFFFFF, 30);
			container.addChild( labelClip );
			labelClip.text = "Something happened :(";
		}
		
		private function handleUploadComplete( event:Event ):void
		{
			var data:String = event.target.data;
			var dataObj:Object = JSON.parse( data );
			AppModel.processedImageData = dataObj;
			
			labelClip = new CustomLabel(AppFonts.ARIAL_BLACK, 0xFFFFFF, 30);
			container.addChild( labelClip );
			labelClip.text = "DONE! :)";
			
			var self:DisplayObject = this;
			
			setTimeout( function():void
			{
				PopUpManager.removePopUp( self );
				AppModel.navigator.showScreen(AppScreens.FINAL_SCREEN);
			}, 500 );
		}
		
		private function handleImageProcessProgress( percentComplete:Number ):void
		{
			imageProcessProgerss.percent = percentComplete;
		}
	}
}