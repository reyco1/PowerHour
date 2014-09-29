package com.reycogames.powerhour.controls
{
	import com.reycogames.powerhour.model.AppFonts;
	import com.reycogames.powerhour.model.AppModel;
	
	import feathers.controls.ImageLoader;
	import feathers.controls.LayoutGroup;
	import feathers.layout.VerticalLayout;
	
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class LargeAddButton extends LayoutGroup
	{
		private var addButton:ImageLoader;
		private var label:CustomLabel;
		
		public  var onTrigger:Function;
		
		public function LargeAddButton()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			addButton = new ImageLoader();
			addButton.source = AppModel.assetManager.getTexture( 'add_icon_large.fw' );
			addButton.maintainAspectRatio = true;
			addButton.width = AppModel.STARLING_SATGE.stageWidth * 0.50;
			addChild( addButton );
			
			label = new CustomLabel(AppFonts.ARIAL_BLACK, 0xFFFFFF, 40);
			label.text = "Touch to add.";
			addChild( label );
			
			var verticalLayout:VerticalLayout = new VerticalLayout();
			verticalLayout.gap = 40;
			verticalLayout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			verticalLayout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_MIDDLE;
			
			layout = verticalLayout;
			
			touchable = true;
			addEventListener( TouchEvent.TOUCH, handlClicked );
		}
		
		private function handlClicked( event:TouchEvent ):void
		{
			var touch:Touch = event.getTouch(this);
			
			if( touch && touch.phase == TouchPhase.BEGAN )
			{
				if(onTrigger != null)
					onTrigger.call(null);
			}
		}
	}
}