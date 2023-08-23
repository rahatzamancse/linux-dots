from gi.repository import Nautilus, GObject, Gtk
import os
import json
import subprocess

class OpenVSCodeExtension(GObject.GObject, Nautilus.MenuProvider):
    def get_background_items(
        self,
        current_folder: Nautilus.FileInfo,
    ) -> list[Nautilus.MenuItem]:
        menu = Nautilus.MenuItem(
            name="ExampleMenuProvider::OpenVSCode",
            label="Open VSCode here",
            tip="",
            icon="",
        )

        menu.connect('activate', self.openvscodehere, current_folder)
        return [ menu ]

    def openvscodehere(
            self,
            menu: Nautilus.MenuItem,
            folder: Nautilus.FileInfo,
        ) -> None:
        subprocess.run(["code", folder.get_location().get_path()])
