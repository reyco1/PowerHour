package com.reycogames.powerhour.screens
{
	import com.reycogames.powerhour.controls.ImageButton;
	import com.reycogames.powerhour.data.Playlist;
	import com.reycogames.powerhour.manager.NativeDialogsManager;
	import com.reycogames.powerhour.model.AppModel;
	import com.reycogames.powerhour.model.AppScreens;
	import com.reycogames.powerhour.model.PlaylistModel;
	import com.reycogames.powerhour.screens.core.AbstractScreen;
	
	import flash.utils.Dictionary;
	
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.data.ListCollection;
	import feathers.events.FeathersEventType;
	import feathers.layout.AnchorLayoutData;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	public class PlaylistScreen extends AbstractScreen
	{
		private var accessoryDictionary:Dictionary;
		private var addIcon:ImageButton;
		private var list:List;
		private var ququedPlaylistForDelete:Object;
		
		public function PlaylistScreen()
		{
			super( "PLAYLISTS" );
			accessoryDictionary = new Dictionary( true );
		}
		
		override protected function initializeHandler():void
		{
			PlaylistModel.loadData();
			
			super.initializeHandler();
			
			addIcon = new ImageButton( "add_icon.fw", AppModel.LOW_RES ? 50 : 75 );	
			addIcon.onTrigger = addNewPlaylist;
			this.headerProperties.rightItems = new <DisplayObject>
				[
					addIcon
				];
			
			list = new List();
			list.addEventListener( Event.CHANGE, handlePlaylistSelected );
			
			list.itemRendererFactory = function():IListItemRenderer
			{
				var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
				renderer.labelField = "title";
				renderer.accessoryPosition = "right";
				renderer.accessoryFunction = function( item:Object ):DisplayObject
				{
					var button:Button = accessoryDictionary[ item ];
					if(!button)
					{
						button = new Button();
						button.label = "Edit";
						button.addEventListener(Event.TRIGGERED, handleButtonTriggered);
						accessoryDictionary[ item ] = button;
						accessoryDictionary[ button ] = item;
					}
					return button;
				}
				renderer.isLongPressEnabled = true;
				return renderer;
			}
			
			list.addEventListener(FeathersEventType.RENDERER_ADD, list_rendererAddHandler);
			list.addEventListener(FeathersEventType.RENDERER_REMOVE, list_rendererRemoveHandler);
			
			var lists:Array = PlaylistModel.playlists;
			
			list.dataProvider = new ListCollection( lists );
			list.autoHideBackground = true;
			list.isSelectable = true;
			list.clipContent = true;
			list.layoutData = new AnchorLayoutData(0,0,0,0);
			addChild( list );
		}
		
		private function list_rendererAddHandler(event:Event, renderer:DefaultListItemRenderer):void
		{
			renderer.addEventListener(FeathersEventType.LONG_PRESS, renderer_longPressHandler);
		}
		
		private function list_rendererRemoveHandler(event:Event, renderer:DefaultListItemRenderer):void
		{
			renderer.removeEventListener(FeathersEventType.LONG_PRESS, renderer_longPressHandler);
		}
		
		private function renderer_longPressHandler(event:Event):void
		{
			var target:DefaultListItemRenderer = event.currentTarget as DefaultListItemRenderer;
			ququedPlaylistForDelete = target.data;
			trace("Are you sure you want to delete " + target.data.title);
			NativeDialogsManager.showDeletePlaylistConfirmation( target.data.title, handleDeletConfired );
		} 
		
		private function handleDeletConfired():void
		{
			PlaylistModel.deletePlaylist( ququedPlaylistForDelete.title );
			list.dataProvider = new ListCollection( PlaylistModel.playlists );
		}
		
		private function handlePlaylistSelected( event:Event ):void
		{
			AppModel.selectedPlaylist = Playlist.create( event.currentTarget["selectedItem"] );
			AppModel.navigator.showScreen( AppScreens.SETUP_GAME_SCREEN );
		}
		
		private function handleButtonTriggered(event:Event):void
		{
			AppModel.playlistSetForEdit = accessoryDictionary[ event.currentTarget ];
			AppModel.navigator.showScreen( AppScreens.PLAY_LIST_VIEW );
		}
		
		private function addNewPlaylist():void
		{
			NativeDialogsManager.showNewPlaylistDialog( handleDialogClose );	
		}
		
		private function handleDialogClose( result:String ):void
		{
			PlaylistModel.addPlaylist( result );
			list.dataProvider = new ListCollection( PlaylistModel.playlists);
		}
		
		override public function dispose():void
		{
			super.dispose();
			accessoryDictionary = null;
		}
	}
}