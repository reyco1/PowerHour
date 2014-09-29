package com.reycogames.powerhour.screens.playlistscreen
{
	import com.reycogames.powerhour.manager.FileManager;
	import com.reycogames.powerhour.model.AppModel;
	
	import flash.filesystem.File;
	import flash.utils.Dictionary;
	
	import feathers.controls.Button;
	import feathers.controls.Check;
	import feathers.controls.LayoutGroup;
	import feathers.controls.List;
	import feathers.controls.Panel;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.core.PopUpManager;
	import feathers.data.ListCollection;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	public class FileBrowserPopup extends Panel
	{
		private var accessoryDictionary:Dictionary;
		private var currentFolder:File;
		private var list:List;
		public var onClose:Function;
		
		public function FileBrowserPopup()
		{
			accessoryDictionary = new Dictionary();
		}
		
		override protected function initialize():void
		{
			super.initialize();
				
			AppModel.tracksToAdd = [];
			
			this.headerProperties.title = "Add tracks";
			
			var verticalLayout:VerticalLayout = new VerticalLayout();			
			this.layout = verticalLayout;
				
			list = new List();
			list.addEventListener( Event.CHANGE, handleListChange );
			
			list.itemRendererFactory = function():IListItemRenderer
			{
				var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
				renderer.labelField = "name";
				renderer.accessoryPosition = "right";
				renderer.accessoryFunction = function( item:Object ):DisplayObject
				{
					if(!item.isDirectory && item.name != "../")
					{
						var check:Check = accessoryDictionary[ item ];
						if(!check)
						{
							check = new Check();
							check.scaleX = check.scaleY = 1.25;
							check.addEventListener(Event.TRIGGERED, checkToggled);
							accessoryDictionary[ item ] = check;
							accessoryDictionary[ check ] = item;
						}
						return check;
					}
					else
						return null;
				};
					
				return renderer;
			}
				
			var rootDir:Array;
			try
			{
				rootDir = File.documentsDirectory.resolvePath("/sdcard/").getDirectoryListing();
			} 
			catch(error:Error) 
			{
				rootDir = File.getRootDirectories();
			}				
			rootDir.unshift( {name:"../"} );
			
			list.dataProvider = new ListCollection( rootDir );
			list.isSelectable = true;
			list.height = stage.stageHeight * 0.75;
			list.width = stage.stageWidth * 0.9;
			list.autoHideBackground = true;
			list.isSelectable = true;
			list.clipContent = true;
			addChild( list );
			
			list.validate();
			
			var group:LayoutGroup = new LayoutGroup();
			group.layout = new HorizontalLayout();
			addChild( group );
			
			var cancelButton:Button = new Button();
			cancelButton.addEventListener(Event.TRIGGERED, closePopup);
			cancelButton.label = "Cancel";
			cancelButton.width = list.width * 0.5
			cancelButton.height = stage.stageHeight * 0.1;
			group.addChild( cancelButton );
			
			var addButton:Button = new Button();
			addButton.addEventListener(Event.TRIGGERED, addnewTracks);
			addButton.label = "Add Tracks";
			addButton.width = list.width * 0.5
			addButton.height = stage.stageHeight * 0.1;
			group.addChild( addButton );
		}
		
		private function closePopup( event:Event ):void
		{
			AppModel.tracksToAdd = [];
			if( onClose != null )
				onClose.call();
			PopUpManager.removePopUp( this );
		}
		
		private function addnewTracks( event:Event ):void
		{
			if( onClose != null )
				onClose.call();
			PopUpManager.removePopUp( this );
		}
		
		private function handleListChange( event:Event ):void
		{
			var list:List = List( event.currentTarget );
			var selectedItem:File = list.selectedItem as File;
			var directories:Array;
			
			if(selectedItem)
			{
				if(selectedItem.isDirectory)
				{
					currentFolder = selectedItem;
					
					directories = FileManager.getDirectoryListing( selectedItem );
					directories.sortOn(["isDirectory"], Array.DESCENDING);
					directories.unshift( {name:"../"} );
					
					list.dataProvider = new ListCollection( directories );
				}
				return;
			}
			
			
			if(list.selectedIndex == 0)
			{
				if(currentFolder != null && currentFolder.parent != null)
				{
					currentFolder = currentFolder.parent;
					
					directories = FileManager.getDirectoryListing( currentFolder );
					directories.sortOn(["isDirectory"], Array.DESCENDING);
					directories.unshift( {name:"../"} );
					
					list.dataProvider = new ListCollection( directories );
				}
				else
				{
					var rootDir:Array;
					try
					{
						rootDir = File.documentsDirectory.resolvePath("/sdcard/").getDirectoryListing();
					} 
					catch(error:Error) 
					{
						rootDir = File.getRootDirectories();
					}
					rootDir.unshift( {name:"../"} );
					
					list.dataProvider = new ListCollection( rootDir );
				}
			}				
		}
		
		private function checkToggled(event:Event):void
		{
			if(!AppModel.tracksToAdd)
				AppModel.tracksToAdd = [];
			AppModel.tracksToAdd.push(accessoryDictionary[ event.currentTarget ]);
		}
	}
}