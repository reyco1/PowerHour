package com.reycogames.powerhour.screens.countdownscreen
{
	import com.reycogames.powerhour.controls.CustomLabel;
	import com.reycogames.powerhour.manager.PauseManager;
	import com.reycogames.powerhour.model.AppFonts;
	import com.reycogames.powerhour.model.AppModel;
	
	import feathers.controls.ImageLoader;
	import feathers.controls.ScrollContainer;
	import feathers.core.PopUpManager;
	import feathers.layout.VerticalLayout;
	
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.TextureSmoothing;
	
	public class PottyBreakView extends ScrollContainer
	{
		private var label:CustomLabel;
		private var potty:ImageLoader;
		
		public var onClick:Function;
		
		public function PottyBreakView()
		{
			
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			touchable = true;
			addEventListener( TouchEvent.TOUCH, handlClicked );
			
			var verticalLayout:VerticalLayout = new VerticalLayout();	
			verticalLayout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_MIDDLE;
			verticalLayout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			verticalLayout.gap = 25;
			this.layout = verticalLayout;
			
			label = new CustomLabel(AppFonts.ARIAL_BLACK, 0xFFFFFF, 40);
			label.text = "POTTY BREAK!";
			addChild( label );
			
			potty = new ImageLoader();
			potty.smoothing = TextureSmoothing.BILINEAR;
			potty.source = AppModel.getTexture( "potty.fw" );
			potty.maintainAspectRatio = true;
			potty.textureScale = 1;
			potty.width = stage.stageWidth * 0.25;
			addChild( potty );
		}
		
		private function handlClicked( event:TouchEvent ):void
		{
			var touch:Touch = event.getTouch(this);
			
			if( touch && touch.phase == TouchPhase.BEGAN )
			{
				PauseManager.resume();
				PopUpManager.removePopUp( this );
			}
		}
	}
}