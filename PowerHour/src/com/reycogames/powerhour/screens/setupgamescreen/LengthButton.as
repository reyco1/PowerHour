package com.reycogames.powerhour.screens.setupgamescreen
{
	import com.reycogames.powerhour.controls.ComplexButton;
	import com.reycogames.powerhour.controls.CustomLabel;
	import com.reycogames.powerhour.model.AppColors;
	import com.reycogames.powerhour.model.AppFonts;
	import com.reycogames.powerhour.model.AppModel;
	
	import feathers.controls.ImageLoader;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.TextureSmoothing;
	
	public class LengthButton extends ComplexButton
	{
		private var clockIcon:ImageLoader;
		private var lengthLabel:CustomLabel;
		private var timeLabel:CustomLabel;
		private var lineImage:Image;
		
		public function LengthButton()
		{
			super();
			
			AppModel.MINUTES = 60;
		}
		
		override protected function initializeHandler(event:Event):void
		{
			super.initializeHandler(event);
			
			clockIcon = new ImageLoader();
			clockIcon.maintainAspectRatio = true;
			clockIcon.smoothing = TextureSmoothing.BILINEAR;
			clockIcon.source = AppModel.getTexture( "clock_icon.fw" );
			clockIcon.x = 15;
			addChild( clockIcon );
			
			clockIcon.validate();
			
			var fontSize:Number = AppModel.LOW_RES ? 46 * 0.6 : 46;
			
			lengthLabel = new CustomLabel( AppFonts.ARIAL_BLACK, AppColors.WHITE, fontSize );	
			addChild( lengthLabel );			
			lengthLabel.text = "LENGTH";
			
			lengthLabel.validate();
			
			timeLabel = new CustomLabel( AppFonts.ARIAL, AppColors.WHITE, fontSize );	
			addChild( timeLabel );			
			timeLabel.text = AppModel.MINUTES + " MIN";
						
			timeLabel.validate();
			
			lineImage  = new Image( AppModel.getTexture("orange_dividing_line.fw") );
			addChild( lineImage );
			
			onTrigger = function():void
			{
				AppModel.MINUTES = AppModel.MINUTES >= 60 ? 5 : AppModel.MINUTES + 5;
				timeLabel.text = (AppModel.MINUTES < 10 ? "0"+AppModel.MINUTES : AppModel.MINUTES) + " MIN";
			}
				
			draw();
		}
		
		private function draw():void
		{
			clockIcon.validate();
			
			lengthLabel.y = clockIcon.y + ((clockIcon.height - lengthLabel.height) * 0.5);
			lengthLabel.x = clockIcon.x + clockIcon.width + 25;
			
			lengthLabel.validate();
			
			timeLabel.y = clockIcon.y + ((clockIcon.height - timeLabel.height) * 0.5) + 3;
			timeLabel.x = stage.stageWidth - timeLabel.width - 25;
			
			timeLabel.validate();
			
			lineImage.width = stage.stageWidth;
			lineImage.y = clockIcon.y + clockIcon.height + 20;
		}
	}
}