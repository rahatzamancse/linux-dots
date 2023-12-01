import gi
gi.require_version('Gtk', '4.0')
from gi.repository import Nautilus, GObject, Gtk
import os
import json

SSH_CACHE_FILE = os.path.expanduser("~/.cache/send_ssh_plugin.cache")

def send_ssh(files: list[str], ssh_path: str, password: str):
    for file in files:
        command = f'sshpass -p {password} scp -r {file} {ssh_path}'
        os.system(command)

def save_ssh_path(ssh_path, password):
    with open(SSH_CACHE_FILE, 'r') as f:
        data = json.load(f)
    with open(SSH_CACHE_FILE, 'w') as f:
        data.append({
            "ssh_path": ssh_path,
            "pass": password,
        })
        f.write(json.dumps(data))

class EntryWindow(Gtk.Window):
    def __init__(self, callback):
        super().__init__(title="Entry Demo")
        self.callback = callback
        self.set_size_request(200, 100)

        vbox = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=6)
        self.set_child(vbox)

        self.ssh_entry = Gtk.Entry()
        self.ssh_entry.set_text("Add New SSH")
        vbox.append(self.ssh_entry)

        self.pass_entry = Gtk.Entry()
        self.pass_entry.set_text("Password")
        vbox.append(self.pass_entry)

        hbox = Gtk.Box(spacing=6)
        vbox.append(hbox)

        # Add a OK button
        button = Gtk.Button(label="OK")
        button.connect("clicked", self.on_button_clicked)
        hbox.append(button)

    def on_button_clicked(self, button):
        ssh_path = self.ssh_entry.get_text()
        password = self.pass_entry.get_text()
        self.callback(ssh_path, password)
        self.destroy()


class SendSSHExtension(GObject.GObject, Nautilus.MenuProvider):
    def __init__(self):
        if not os.path.exists(SSH_CACHE_FILE):
            with open(SSH_CACHE_FILE, 'w') as f:
                f.write("[]")


    def get_file_items(
        self,
        files: list[Nautilus.FileInfo],
    ) -> list[Nautilus.MenuItem]:

        top_menuitem = Nautilus.MenuItem(
            name="ExampleMenuProvider::SendSSH",
            label="Send via SSH",
            tip="",
            icon="",
        )

        submenu = Nautilus.Menu()
        top_menuitem.set_submenu(submenu)

        new_path_menuitem = Nautilus.MenuItem(
            name="ExampleMenuProvider::SetSSH",
            label="New SSH Path",
            tip="",
            icon="",
        )
        new_path_menuitem.connect('activate', self.new_ssh_activate_cb, files)
        submenu.append_item(new_path_menuitem)

        with open(SSH_CACHE_FILE, 'r') as f:
            ssh_paths = json.load(f)
        for ssh_path in ssh_paths:
            menuitem = Nautilus.MenuItem(
                name="ExampleMenuProvider::SSH",
                label=ssh_path['ssh_path'],
                tip="",
                icon="",
            )
            menuitem.connect('activate', self.ssh_activate_cb, files, ssh_path['ssh_path'], ssh_path['pass'])
            submenu.append_item(menuitem)

        clear_ssh_paths_menuitem = Nautilus.MenuItem(
            name="ExampleMenuProvider::ClearSSH",
            label="Clear Saved Paths",
            tip="",
            icon="",
        )
        clear_ssh_paths_menuitem.connect('activate', self.clear_saved_ssh_paths_cb)
        submenu.append_item(clear_ssh_paths_menuitem)

        return [
            top_menuitem,
        ]

    def clear_saved_ssh_paths_cb(
            self,
            menu: Nautilus.MenuItem,
        ):
        with open(SSH_CACHE_FILE, 'w') as f:
            f.write("[]")

    # Even though we're not using background items, Nautilus will generate
    # a warning if the method isn't present
    def get_background_items(
        self,
        current_folder: Nautilus.FileInfo,
    ) -> list[Nautilus.MenuItem]:
        return []

    def new_ssh_activate_cb(
            self,
            menu: Nautilus.MenuItem,
            files: list[Nautilus.FileInfo],

        ) -> None:
        files = [file.get_location().get_path() for file in files]
        dialog = EntryWindow(lambda ssh_path, password: (send_ssh(files, ssh_path, password), save_ssh_path(ssh_path, password)))
        dialog.present()

    def ssh_activate_cb(
            self,
            menu: Nautilus.MenuItem,
            files: list[Nautilus.FileInfo],
            ssh_path: str,
            password: str,
        ) -> None:
            files = [file.get_location().get_path() for file in files]
            send_ssh(files, ssh_path, password)

