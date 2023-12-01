from gi.repository import Nautilus, GObject, Gtk, Gdk, GLib
import os
import json
import subprocess


class GitCloneExtension(GObject.GObject, Nautilus.MenuProvider):
    def get_background_items(
        self,
        current_folder: Nautilus.FileInfo,
    ) -> list[Nautilus.MenuItem]:
        menu = Nautilus.MenuItem(
            name="ExampleMenuProvider::GitClone",
            label="Git Clone from Clipboard",
            tip="",
            icon="",
        )

        menu.connect("activate", self.gitclone, current_folder)
        return [menu]

    def gitclone(
        self,
        menu: Nautilus.MenuItem,
        folder: Nautilus.FileInfo,
    ) -> None:
        self.path = folder.get_location().get_path()

        # get clipboard
        clipboard = Gdk.Display().get_default().get_clipboard()
        clipboard.read_text_async(
            cancellable=None, callback=self.git_clone, user_data=None
        )




    def git_clone(self, clipboard, task, data):
        text = clipboard.read_text_finish(task)
        process = subprocess.run(["git", "clone", "--recursive", text, self.path])
        # if the process fails, show an error message
        if process.returncode != 0:
            dialog = Gtk.MessageDialog.new(
                None,
                0,
                Gtk.MessageType.ERROR,
                Gtk.ButtonsType.CLOSE,
                "Error cloning repository",
            )

            dialog.run()
            dialog.destroy()