package com.reycogames.powerhour.screens.core
{
	import com.reycogames.powerhour.manager.ShareManager;
	
	import flash.utils.setTimeout;
	
	import feathers.controls.Panel;
	import feathers.core.PopUpManager;
	import feathers.layout.VerticalLayout;
	
	import starling.display.DisplayObject;
	
	public class SharePopup extends Panel
	{
		private var link:String;
		
		public function SharePopup( link:String = null )
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			headerProperties.title = "Share this!";
			
			var verticalLayout:VerticalLayout = new VerticalLayout();
			verticalLayout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_MIDDLE;
			verticalLayout.gap = 75;
			
			layout = verticalLayout;
			
			var popup:DisplayObject = this;
			
			var facebook:ShareButton = new ShareButton("fb", "Share on Facebook");
			facebook.onTrigger = function():void
			{
				ShareManager.shareOnFacebook( link );
				setTimeout( PopUpManager.removePopUp, 1000, popup );
			};
			addChild( facebook );
			
			var twitter:ShareButton = new ShareButton("twitter", "Share on Twitter");
			twitter.onTrigger = function():void
			{
				ShareManager.shareOnTwitter( link );
				setTimeout( PopUpManager.removePopUp, 1000, popup );
			};
			addChild( twitter );
			
			var email:ShareButton = new ShareButton("google_plus", "Share via Google+");
			email.onTrigger = function():void
			{
				ShareManager.shareOnGooglePlus( link );
				setTimeout( PopUpManager.removePopUp, 1000, popup );
			};
			addChild( email );
		}
	}
}

import com.reycogames.powerhour.controls.CustomLabel;
import com.reycogames.powerhour.model.AppFonts;
import com.reycogames.powerhour.model.AppModel;

import feathers.controls.ImageLoader;
import feathers.controls.LayoutGroup;
import feathers.layout.HorizontalLayout;
import feathers.layout.VerticalLayout;

import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

class ShareButton extends LayoutGroup
{
	public var onTrigger:Function;
	
	private var imagePath:String;
	private var labelText:String;
	private var thumbnail:ImageLoader;
	private var label:CustomLabel;
	
	public function ShareButton(imagePath:String, labelText:String):void
	{
		this.imagePath = imagePath;
		this.labelText  = labelText;
	}
	
	override protected function initialize():void
	{
		super.initialize();
		
		var horizontalLayout:HorizontalLayout = new HorizontalLayout();
		horizontalLayout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_CENTER;
		horizontalLayout.verticalAlign   = HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
		horizontalLayout.gap = 20;
		layout = horizontalLayout;
		
		thumbnail = new ImageLoader();
		thumbnail.maintainAspectRatio = true;
		thumbnail.height = stage.stageHeight * 0.10;
		thumbnail.source = AppModel.getTexture( imagePath );
		addChild( thumbnail );
		
		label = new CustomLabel( AppFonts.ARIAL_BLACK, 0xFFFFFF, 30 );
		label.text = labelText;
		addChild( label );
		
		touchable = true;
		
		addEventListener( TouchEvent.TOUCH, handlClicked );
	}
	
	private function handlClicked( event:TouchEvent ):void
	{
		var touch:Touch = event.getTouch(this);
		
		if( touch && touch.phase == TouchPhase.BEGAN )
		{
			alpha = 0.5;
			if(onTrigger != null)
				onTrigger.call(null);
		}
		
		if( touch && touch.phase == TouchPhase.ENDED )
		{
			alpha = 1;
		}
	}
}