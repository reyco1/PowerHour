package com.reycogames.powerhour.screens
{
	import com.reycogames.powerhour.controls.ConfirmSnapshotUI;
	import com.reycogames.powerhour.manager.CameraManager;
	import com.reycogames.powerhour.screens.core.AbstractScreen;
	
	import feathers.controls.LayoutGroup;
	import feathers.layout.AnchorLayoutData;
	
	public class ConfirmSnapshotScreen extends AbstractScreen
	{
		private var container:LayoutGroup;
		private var confirmSnapshotUI:ConfirmSnapshotUI;
		private var imageObject:Object;
		
		public function ConfirmSnapshotScreen()
		{
			super("LET'S DRINK!");
		}
		
		override protected function initializeHandler():void
		{
			super.initializeHandler();
			
			container = new LayoutGroup();
			container.layoutData = new AnchorLayoutData(0, 0, 0, 0);
			addChild( container );
			
			imageObject = CameraManager.getSnapShot();
			container.addChild( imageObject.snapshot );
			
			confirmSnapshotUI = new ConfirmSnapshotUI( imageObject.bitmapData );
			container.addChild( confirmSnapshotUI );
		}
		
		override protected function draw():void
		{
			super.draw();
			
			imageObject.snapshot.validate();
			imageObject.snapshot.width = stage.stageWidth - 20;
			imageObject.snapshot.x = 10;
			
			confirmSnapshotUI.validate();
			confirmSnapshotUI.y = container.height - confirmSnapshotUI.height;
		}
	}
}