from gi.repository import Nautilus, GObject, Gtk
import os
import json
import tempfile
import subprocess

def run_background_process(command):
    """Runs a background process and returns its PID."""
    process = subprocess.Popen(command, shell=True)
    return process.pid

temp_file = "nautilus-live-server.txt"
temp_file_path = os.path.join(tempfile.gettempdir(), temp_file)
START_PORT = 8080

class OpenLiveServerExtension(GObject.GObject, Nautilus.MenuProvider):
    def __init__(self):
        if not os.path.exists(temp_file_path):
            with open(temp_file_path, "w") as f:
                f.write("[]")

    def get_file_items(
        self,
        files: list[Nautilus.FileInfo],
    ) -> list[Nautilus.MenuItem]:
        if len(files) == 0:
            return []
        return self.get_menu(files[0], files[0])

    def kill_all_servers(
            self,
            menu: Nautilus.MenuItem,
        ):
        with open(temp_file_path, 'r') as f:
            servers = json.load(f)
            for server in servers:
                subprocess.run(f"kill {server['pid']}", shell=True)
        with open(temp_file_path, 'w') as f:
            f.write("[]")
            
    def get_menu(self, current_folder: Nautilus.FileInfo, current_file: Nautilus.FileInfo | None = None) -> Nautilus.Menu:
        top_menuitem = Nautilus.MenuItem(
            name="MenuProvider::OpenLiveServer",
            label="Live Servers",
            tip="",
            icon="",
        )
        
        submenu = Nautilus.Menu()
        top_menuitem.set_submenu(submenu)

        new_path_menuitem = Nautilus.MenuItem(
            name="MenuProvider::CreateNew",
            label="Open Live Server",
            tip="",
            icon="",
        )
        new_path_menuitem.connect('activate', self.new_live_server, current_folder)
        submenu.append_item(new_path_menuitem)

        with open(temp_file_path, 'r') as f:
            servers = json.load(f)
        for server in servers:
            menuitem = Nautilus.MenuItem(
                name="MenuProvider::KillServer",
                label=f"{server['port']}: {server['dir']}",
                tip="",
                icon="",
            )
            menuitem.connect('activate', self.kill_server, server['pid'])
            submenu.append_item(menuitem)

        killall_menuitem = Nautilus.MenuItem(
            name="MenuProvider::KillAll",
            label="Kill All Servers",
            tip="",
            icon="",
        )
        killall_menuitem.connect('activate', self.kill_all_servers)
        submenu.append_item(killall_menuitem)

        return [
            top_menuitem,
        ]

    def get_background_items(
        self,
        current_folder: Nautilus.FileInfo,
    ) -> list[Nautilus.MenuItem]:
        return self.get_menu(current_folder)

    def new_live_server(
            self,
            menu: Nautilus.MenuItem,
            folder: Nautilus.FileInfo,
        ) -> None:
        folder = folder.get_location().get_path()
        with open(temp_file_path, 'r') as f:
            servers = json.load(f)
            new_port = START_PORT
            if servers:
                new_port = max([server['port'] for server in servers]) + 1
            pid = run_background_process(f"python -m http.server {new_port} --directory {folder}")
            servers.append({
                "port": new_port,
                "dir": folder.split('/')[-1],
                "pid": pid,
            })
        with open(temp_file_path, 'w') as f:
            json.dump(servers, f)
            
        file = None
        for f in os.listdir(folder):
            if f == 'index.html' or f == 'index.htm':
                file = f
                break
        if not file:
            cnt = 0
            for f in os.listdir(folder):
                if f.endswith('.html') or f.endswith('.htm'):
                    file = f
                    cnt += 1
                if cnt > 1:
                    file = None
                    break
        if file:
            subprocess.run(f"xdg-open http://localhost:{new_port}/{f}", shell=True)
        else:
            subprocess.run(f"xdg-open http://localhost:{new_port}", shell=True)

    def kill_server(
            self,
            menu: Nautilus.MenuItem,
            pid: int,
        ) -> None:
            with open(temp_file_path, 'r') as f:
                servers = json.load(f)
                for server in servers:
                    if server['pid'] == pid:
                        subprocess.run(f"kill {pid}", shell=True)
                        servers.remove(server)
            with open(temp_file_path, 'w') as f:
                json.dump(servers, f)
