package com.reycogames.powerhour.screens.playlistscreen
{
	import com.reycogames.powerhour.controls.ImageButton;
	import com.reycogames.powerhour.controls.LargeAddButton;
	import com.reycogames.powerhour.model.AppModel;
	import com.reycogames.powerhour.model.AppScreens;
	import com.reycogames.powerhour.model.PlaylistModel;
	import com.reycogames.powerhour.screens.core.AbstractScreen;
	
	import flash.utils.Dictionary;
	
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.core.PopUpManager;
	import feathers.data.ListCollection;
	import feathers.layout.AnchorLayoutData;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class PlaylistView extends AbstractScreen
	{
		private var accessoryDictionary:Dictionary;
		private var addIcon:ImageButton;
		private var list:List;
		private var doneButton:Button;
		private var largeAddButton:LargeAddButton;
		
		public function PlaylistView()
		{
			super( AppModel.playlistSetForEdit.title );
			accessoryDictionary = new Dictionary( true );
		}
		
		override protected function initializeHandler():void
		{
			super.initializeHandler();
			
			addIcon = new ImageButton( "add_icon.fw", AppModel.LOW_RES ? 50 : 75 );	
			addIcon.onTrigger = addNewTracks;
			this.headerProperties.rightItems = new <DisplayObject>
				[
					addIcon
				];
			
			var tracks:Array = AppModel.playlistSetForEdit.tracks;
			if(tracks.length > 0)
			{
				createTrackList( tracks );
			}
			else
			{
				showAddButton();
			}			
			
			doneButton = new Button();
			doneButton.label = "Done";
			doneButton.setSize((AppModel.STARLING_SATGE.stageWidth * 0.25), 100);
			doneButton.addEventListener( TouchEvent.TOUCH, handlClicked );
			addChild(doneButton);
		}
		
		private function showAddButton():void
		{
			largeAddButton = new LargeAddButton();
			largeAddButton.layoutData = new AnchorLayoutData(0,0,0,0);
			largeAddButton.onTrigger = addNewTracks;
			addChild( largeAddButton );
		}
		
		private function createTrackList(tracks:Array):void
		{
			if(largeAddButton)
			{
				largeAddButton.dispose();
				removeChild( largeAddButton );
				largeAddButton = null;
			}
			
			list = new List();
			
			list.itemRendererFactory = function():IListItemRenderer
			{
				var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
				renderer.labelField = "name";
				renderer.accessoryPosition = "right";
				renderer.accessoryFunction = function( item:Object ):DisplayObject
				{
					var button:Button = accessoryDictionary[ item ];
					if(!button)
					{
						button = new Button();
						button.label = "Remove";
						button.addEventListener(Event.TRIGGERED, handleRemoveButtonTriggered);
						accessoryDictionary[ item ] = button;
						accessoryDictionary[ button ] = item;
					}
					return button;
				};
				
				return renderer;
			};
			
			list.dataProvider = new ListCollection( tracks );
			
			list.autoHideBackground = true;
			list.isSelectable = true;
			list.clipContent = true;
			list.layoutData = new AnchorLayoutData(0,0,0,0);
			addChildAt( list, 0 );
		}
		
		private function handlClicked( event:TouchEvent ):void
		{
			var touch:Touch = event.getTouch(this);
			
			if( touch && touch.phase == TouchPhase.BEGAN )
			{
				AppModel.navigator.showScreen( AppScreens.PLAYLIST_SCREEN );
			}
		}
		
		override protected function draw():void
		{
			super.draw();
			
			doneButton.validate();
			
			doneButton.x = (stage.stageWidth  - doneButton.width) * 0.5;
			doneButton.y = (stage.stageHeight - doneButton.height - 20 - this.header.height);
		}
		
		private function handleRemoveButtonTriggered( event:Event ):void
		{
			var item:Object = accessoryDictionary[ event.currentTarget ];
			PlaylistModel.deleteTrack( AppModel.playlistSetForEdit.title, item.name );
			
			if(AppModel.playlistSetForEdit.tracks.length == 0)
			{
				list.dispose();
				removeChild( list );
				list = null;				
				showAddButton();
				return;
			}
			
			list.dataProvider = new ListCollection( AppModel.playlistSetForEdit.tracks );
		}
		
		private function addNewTracks():void
		{
			var popup:FileBrowserPopup = new FileBrowserPopup();
			popup.onClose = handlePopupClosed;
			PopUpManager.addPopUp( popup, true, true );
		}
		
		protected function handlePopupClosed():void
		{
			var newTracks:Array = AppModel.tracksToAdd;
			for (var a:int = 0; a < newTracks.length; a++) 
			{
				PlaylistModel.addTrack( AppModel.playlistSetForEdit.title, newTracks[a].name, newTracks[a].url, a == newTracks.length-1 );
			}
			
			if(list)
				list.dataProvider = new ListCollection( AppModel.playlistSetForEdit.tracks );
			else
				createTrackList( AppModel.playlistSetForEdit.tracks );
		}
	}
}