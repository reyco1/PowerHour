package com.reycogames.powerhour.screens
{
	import com.reycogames.powerhour.controls.ImageButton;
	import com.reycogames.powerhour.controls.LargeAddButton;
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
		private var queuedPlaylistForDeletion:Object;
		private var largeAddButton:LargeAddButton;
		
		public function PlaylistScreen()
		{
			super( "PLAYLISTS" );
			accessoryDictionary = new Dictionary( true );
		}
		
		override protected function initializeHandler():void
		{
			super.initializeHandler();
			
			// load all the playlists
			PlaylistModel.loadData();
			var lists:Array = PlaylistModel.playlists;
			
			if(lists.length > 0)
			{
				createPlaylist( lists );
			}
			else
			{
				showAddButton();
			}
			
			// add the "add" icon to the headeer to replace the cup icon
			addIcon = new ImageButton( "add_icon.fw", AppModel.LOW_RES ? 50 : 75 );	
			addIcon.onTrigger = addNewPlaylist;
			this.headerProperties.rightItems = new <DisplayObject>
				[
					addIcon
				];
		}
		
		private function showAddButton():void
		{
			largeAddButton = new LargeAddButton();
			largeAddButton.layoutData = new AnchorLayoutData(0,0,0,0);
			largeAddButton.onTrigger = addNewPlaylist;
			addChild( largeAddButton );
		}
		
		private function createPlaylist( lists:Array ):void
		{
			if(largeAddButton)
			{
				largeAddButton.dispose();
				removeChild( largeAddButton );
				largeAddButton = null;
			}
			
			// create a new list
			list = new List();
			list.addEventListener( Event.CHANGE, handlePlaylistSelected );
			
			// create an item renderer for the list with an "edit" button
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
			
			// add event listeners for the list render	
			list.addEventListener(FeathersEventType.RENDERER_ADD, list_rendererAddHandler);
			list.addEventListener(FeathersEventType.RENDERER_REMOVE, list_rendererRemoveHandler);
			
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
			queuedPlaylistForDeletion = target.data;
			trace("Are you sure you want to delete " + target.data.title);
			NativeDialogsManager.showDeletePlaylistConfirmation( target.data.title, handleDeleteConfirmed );
		} 
		
		private function handleDeleteConfirmed():void
		{
			PlaylistModel.deletePlaylist( queuedPlaylistForDeletion.title );
			
			if(PlaylistModel.playlists.length == 0)
			{
				list.dispose();
				removeChild( list );
				list = null;
				showAddButton();
				return;
			}
			
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
			if(list)
				list.dataProvider = new ListCollection( PlaylistModel.playlists );
			else
				createPlaylist( PlaylistModel.playlists );
		}
		
		override public function dispose():void
		{
			super.dispose();
			accessoryDictionary = null;
		}
	}
}