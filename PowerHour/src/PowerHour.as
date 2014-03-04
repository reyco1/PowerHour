package
{
	import com.distriqt.extension.camera.Camera;
	import com.distriqt.extension.dialog.Dialog;
	import com.reycogames.powerhour.ApplicationContainer;
	import com.reycogames.powerhour.manager.PauseManager;
	import com.reycogames.powerhour.model.AppModel;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import starling.core.Starling;
	
	[SWF(width="960",height="640",frameRate="60",backgroundColor="#F04937")]
	public class PowerHour extends Sprite
	{
		private var starlingEngine:Starling;
		
		public function PowerHour()
		{
			Dialog.init( AppModel.DISTRIQT_DEV_KEY );
			Camera.init( AppModel.DISTRIQT_DEV_KEY );
			
			if(this.stage)
			{
				this.stage.scaleMode = StageScaleMode.NO_SCALE;
				this.stage.align 	 = StageAlign.TOP_LEFT;
			}
			
			this.mouseEnabled = this.mouseChildren = false;
			loaderInfo.addEventListener( Event.COMPLETE, onLoadComplete );
		}
		
		protected function onLoadComplete(event:Event):void
		{
			Starling.handleLostContext = true;	
			Starling.multitouchEnabled = false;
			
			starlingEngine = new Starling( ApplicationContainer, stage );
			starlingEngine.showStats = true;
			starlingEngine.enableErrorChecking = false;
			starlingEngine.start();
			
			stage.addEventListener(Event.RESIZE, onStageResize );
			stage.addEventListener(Event.DEACTIVATE, onStageDeactivate );
		}
		
		protected function onStageResize(event:Event):void
		{
			starlingEngine.stage.stageWidth  = stage.stageWidth;
			starlingEngine.stage.stageHeight = stage.stageHeight;
			
			const viewport:Rectangle 		 = starlingEngine.viewPort;
			viewport.width 					 = stage.stageWidth;
			viewport.height 				 = stage.stageHeight;
			
			try
			{
				starlingEngine.viewPort		= viewport;
			} 
			catch(error:Error) {}
		}
		
		protected function onStageDeactivate(event:Event):void
		{
			Camera.instance.release();
			starlingEngine.stop();
			stage.addEventListener(Event.ACTIVATE, onStageActivate, false, 0, true );
			
			PauseManager.pause();
		}
		
		protected function onStageActivate(event:Event):void
		{
			Camera.instance.initialise();
			stage.removeEventListener(Event.ACTIVATE, onStageActivate );
			starlingEngine.start();
			
			PauseManager.resume();
		}
	}
}