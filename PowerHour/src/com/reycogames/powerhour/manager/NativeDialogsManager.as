package com.reycogames.powerhour.manager
{
	import com.milkmangames.nativeextensions.CoreMobile;
	import com.milkmangames.nativeextensions.events.CMDialogEvent;

	public class NativeDialogsManager
	{
		public static var onCloseHandler:Function;
		
		public static function initialize():void
		{
			if(CoreMobile.isSupported())
			{
				CoreMobile.create();
			}
			else {
				trace("[NativeDialogsManager]", "Core Mobile only works on iOS or Android.");
			}
		}
		
		public static function showNewPlaylistDialog( onCloseHandler:Function ):void
		{
			CoreMobile.mobile.showModalInputDialog("New Playlist", "Enter the name for your new playlist.", "OK", "Type name here", "Cancel").
				addDismissListener(function(e:CMDialogEvent):void
				{
					if (e.selectedButtonLabel=="OK") 
					{
						trace("[NativeDialogsManager]", "Your Name: "+e.modalUserInput);
						onCloseHandler.call(null, e.modalUserInput);
					} 
					else 
					{
						trace("[NativeDialogsManager]", "You didn't enter a name.");
					}
				});
		}
		
		public static function showDeletePlaylistConfirmation( playlistName:String, onCloseHandler:Function ):void
		{
			CoreMobile.mobile.showModalYesNoDialog("Delete Playlist?", "Are you sure you want to delete " + playlistName + "?", "Cancel", "Delete").
				addDismissListener(function(e:CMDialogEvent):void
				{
					if (e.selectedButtonLabel=="Delete") 
					{
						trace("[NativeDialogsManager]", "Deleting playlist");
						onCloseHandler.call();
					} 
					else 
					{
						trace("[NativeDialogsManager]", "Cancelling playlist delete");
					}
				});
		}
		
		public static function showAreYouSureDialog( onCloseHandler:Function ):void
		{
			CoreMobile.mobile.showModalYesNoDialog("Stop playing?", "Are you sure you want to end this party?", "Yes I do!", "Nope.").
				addDismissListener(function(e:CMDialogEvent):void
				{
					if (e.selectedButtonLabel=="Yes I do!") 
					{
						onCloseHandler.call();
					}
				});
		}
		
		public static function showNoPlaylistSelectedAlert():void
		{
			CoreMobile.mobile.showModalConfirmationDialog("Uh oh!?", "Please make sure you selected a Playlist before you start.", "OK");
		}
	}
}