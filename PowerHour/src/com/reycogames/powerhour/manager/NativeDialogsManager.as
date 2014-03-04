package com.reycogames.powerhour.manager
{
	import com.distriqt.extension.dialog.Dialog;
	import com.distriqt.extension.dialog.events.DialogEvent;

	public class NativeDialogsManager
	{
		public static var onCloseHandler:Function;
		
		public static function showNewPlaylistDialog( onCloseHandler:Function ):void
		{
			NativeDialogsManager.onCloseHandler = onCloseHandler;
			Dialog.service.showTextInputAlertDialog(0, "New Playlist", "Enter the name for your new playlist.", false, "Cancel", ["Add Playlist"]);
			Dialog.service.addEventListener(DialogEvent.DIALOG_CLOSED, handleNewPlaylistDialogClosed);
		}
		
		public static function showDeletePlaylistConfirmation( playlistName:String, onCloseHandler:Function ):void
		{
			NativeDialogsManager.onCloseHandler = onCloseHandler;
			Dialog.service.showAlertDialog( 1, "Delete Playlist?", "Are you sure you want to delete " + playlistName + "?", "Cancel", ["Delete"]);
			Dialog.service.addEventListener(DialogEvent.DIALOG_CLOSED, handleDeletePlaylistConfirmationDialogClosed);
		}
		
		protected static function handleDeletePlaylistConfirmationDialogClosed(event:DialogEvent):void
		{
			Dialog.service.removeEventListener(DialogEvent.DIALOG_CLOSED, handleDeletePlaylistConfirmationDialogClosed);
			if(event.data != "0")
			{
				NativeDialogsManager.onCloseHandler.call();
			}
			NativeDialogsManager.onCloseHandler = null;
		}
		
		protected static function handleNewPlaylistDialogClosed(event:DialogEvent):void
		{
			Dialog.service.removeEventListener(DialogEvent.DIALOG_CLOSED, handleNewPlaylistDialogClosed);
			if(event.data == "1" && event.inputA != "")
			{
				NativeDialogsManager.onCloseHandler.call( null, event.inputA );
			}
			NativeDialogsManager.onCloseHandler = null;
		}
	}
}