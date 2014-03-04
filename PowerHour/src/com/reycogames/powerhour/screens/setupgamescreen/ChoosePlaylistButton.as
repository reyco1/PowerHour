package com.reycogames.powerhour.screens.setupgamescreen
{
	import com.reycogames.powerhour.controls.ComplexButton;
	import com.reycogames.powerhour.controls.CustomLabel;
	import com.reycogames.powerhour.model.AppColors;
	import com.reycogames.powerhour.model.AppFonts;
	import com.reycogames.powerhour.model.AppModel;
	import com.reycogames.powerhour.model.AppScreens;
	
	import feathers.controls.ImageLoader;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.TextureSmoothing;
	
	public class ChoosePlaylistButton extends ComplexButton
	{
		private var plusIcon:ImageLoader;
		private var chooseLabel:CustomLabel;
		private var playlistLabel:CustomLabel;
		private var lineImage:Image;
		public function ChoosePlaylistButton()
		{
			super();
		}
		
		override protected function initializeHandler(event:Event):void
		{
			super.initializeHandler(event);
			
			var fontSize:Number = AppModel.LOW_RES ? 46 * 0.6 : 46;
			
			plusIcon = new ImageLoader();
			plusIcon.maintainAspectRatio = true;
			plusIcon.smoothing = TextureSmoothing.BILINEAR;
			plusIcon.source = AppModel.getTexture( "add_icon_opaque.fw" );
			plusIcon.x = 15;
			addChild( plusIcon ); 
			
			plusIcon.validate();
			
			chooseLabel = new CustomLabel( AppFonts.ARIAL_BLACK, AppColors.WHITE, fontSize );	
			addChild( chooseLabel );			
			chooseLabel.text = AppModel.selectedPlaylist == null ? "CHOOSE" : AppModel.selectedPlaylist.title;
			
			chooseLabel.validate();
			
			playlistLabel = new CustomLabel( AppFonts.ARIAL, AppColors.WHITE, fontSize );		
			addChild( playlistLabel );			
			playlistLabel.text = "PLAYLIST";
			
			playlistLabel.validate();
			
			if(AppModel.selectedPlaylist != null)
			{
				playlistLabel.visible = false;
			}
			
			lineImage  = new Image( AppModel.getTexture("orange_dividing_line.fw") );
			addChild( lineImage );
			
			onTrigger = function():void
			{
				AppModel.navigator.showScreen( AppScreens.PLAYLIST_SCREEN );
			}
			
			draw();
		}
		
		private function draw():void
		{
			plusIcon.validate();
			
			chooseLabel.y = plusIcon.y + ((plusIcon.height - chooseLabel.height) * 0.5);
			chooseLabel.x = plusIcon.x + plusIcon.width + 25;
			
			chooseLabel.validate();
			
			playlistLabel.y = chooseLabel.y + ((chooseLabel.height - playlistLabel.height) * 0.5) + 2;
			playlistLabel.x = chooseLabel.x + chooseLabel.width + 10;
			
			playlistLabel.validate();
			
			lineImage.width = stage.stageWidth;
			lineImage.y = plusIcon.y + plusIcon.height + 20;
		}
	}
}