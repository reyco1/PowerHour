package com.reycogames.powerhour.screens.processimaegscreen
{
	import com.reycogames.powerhour.controls.CustomLabel;
	import com.reycogames.powerhour.data.EmbeddedAssets;
	import com.reycogames.powerhour.model.AppFonts;
	import com.reycogames.powerhour.model.AppModel;
	
	import flash.geom.Rectangle;
	
	import feathers.controls.LayoutGroup;
	import feathers.controls.ProgressBar;
	import feathers.display.Scale9Image;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	import feathers.textures.Scale9Textures;
	
	import starling.textures.Texture;
	
	public class ProgressComponent extends LayoutGroup
	{
		private var containerLayout:HorizontalLayout;
		private var labelContainer:LayoutGroup;
		private var labelClip:CustomLabel;
		private var percentLabel:CustomLabel;
		private var progressBar:ProgressBar;
		private var mainLayout:VerticalLayout;
		
		public function ProgressComponent()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
						
			labelClip = new CustomLabel(AppFonts.ARIAL_BLACK, 0xFFFFFF, 30);
			addChild( labelClip );
			
			containerLayout = new HorizontalLayout();
			containerLayout.gap = 5;
			containerLayout.verticalAlign = HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
			
			labelContainer = new LayoutGroup();
			labelContainer.layout = containerLayout;
			addChild( labelContainer );
			
			progressBar = new ProgressBar();
			progressBar.width = stage.stageWidth * 0.60;
			progressBar.height = 75;
			progressBar.minimum = 0;
			progressBar.maximum = 100;
			progressBar.value = 0;
			labelContainer.addChild( progressBar );
			
			percentLabel = new CustomLabel(AppFonts.ARIAL_BLACK, 0xFFFFFF, 30);
			labelContainer.addChild( percentLabel );
			
			var texture:Texture = EmbeddedAssets.LOAD_BAR_BACKGROUND;
			var rect:Rectangle = new Rectangle( 7, 4, 345, 12 );
			var textures:Scale9Textures = new Scale9Textures( texture, rect );
			
			var backgroundSkin:Scale9Image = new Scale9Image( textures );
			backgroundSkin.width = 150;
			progressBar.backgroundSkin = backgroundSkin;
			
			mainLayout = new VerticalLayout();
			mainLayout.gap = 20;
			
			layout = mainLayout;
		}
		
		public function set label( value:String ):void
		{
			labelClip.text = value;
			labelClip.validate();
		}
		
		public function set percent( value:Number ):void
		{
			percentLabel.text = Math.ceil(value) + "%";
			percentLabel.validate();
			
			progressBar.value = value;
			progressBar.validate();
		}
	}
}