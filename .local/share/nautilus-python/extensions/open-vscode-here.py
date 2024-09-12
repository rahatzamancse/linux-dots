from gi.repository import Nautilus, GObject, Gtk
import os
import json
import subprocess

class OpenVSCodeExtension(GObject.GObject, Nautilus.MenuProvider):
    def __init__(self):
        self.vscode_installed = True
        self.cursor_installed = True
        # check if vscode is installed
        process = subprocess.run(["code", "--version"], capture_output=True)
        if process.returncode != 0:
            self.vscode_installed = False
        
        # check if cursor is installed
        process = subprocess.run(["which", "cursor"], capture_output=True)
        if process.returncode != 0:
            self.cursor_installed = False
            
        print("vscode_installed:", self.vscode_installed, "cursor_installed:", self.cursor_installed)
        
        
    def get_background_items(
        self,
        current_folder: Nautilus.FileInfo,
    ) -> list[Nautilus.MenuItem]:
        items = []
        if self.vscode_installed:
            menu = Nautilus.MenuItem(
                name="MenuProvider::OpenVSCode",
                label="Open VSCode here",
                tip="",
                icon="",
            )

            menu.connect('activate', self.openvscodehere, current_folder)
            items.append(menu)
        
        if self.cursor_installed:
            menu = Nautilus.MenuItem(
                name="MenuProvider::OpenCursorHere",
                label="Open Cursor here",
                tip="",
                icon="",
            )

            menu.connect('activate', self.opencursorhere, current_folder)
            items.append(menu)
        
        return items

    def openvscodehere(
            self,
            menu: Nautilus.MenuItem,
            folder: Nautilus.FileInfo,
        ) -> None:
        subprocess.run(["code", folder.get_location().get_path()])

    def opencursorhere(
            self,
            menu: Nautilus.MenuItem,
            folder: Nautilus.FileInfo,
        ) -> None:
        subprocess.run(["cursor", folder.get_location().get_path()])