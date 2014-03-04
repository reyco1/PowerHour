package com.reycogames.powerhour.screens.playlistscreen
{
	import com.reycogames.powerhour.controls.ImageButton;
	import com.reycogames.powerhour.model.AppModel;
	import com.reycogames.powerhour.model.PlaylistModel;
	import com.reycogames.powerhour.screens.core.AbstractScreen;
	
	import flash.utils.Dictionary;
	import flash.utils.setTimeout;
	
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.core.PopUpManager;
	import feathers.data.ListCollection;
	import feathers.layout.AnchorLayoutData;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	public class PlaylistView extends AbstractScreen
	{
		private var accessoryDictionary:Dictionary;
		private var addIcon:ImageButton;
		private var list:List;
		
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
				
			var tracks:Array = AppModel.playlistSetForEdit.tracks;
			list.dataProvider = new ListCollection( tracks );
			
			list.autoHideBackground = true;
			list.isSelectable = true;
			list.clipContent = true;
			list.layoutData = new AnchorLayoutData(0,0,0,0);
			addChild( list );
		}
		
		private function handleRemoveButtonTriggered( event:Event ):void
		{
			var item:Object = accessoryDictionary[ event.currentTarget ];
			PlaylistModel.deleteTrack( AppModel.playlistSetForEdit.title, item.name );
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
			list.dataProvider = new ListCollection( AppModel.playlistSetForEdit.tracks );
		}
	}
}