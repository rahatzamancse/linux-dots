# VSCode Nautilus Extension
#
# Place me in ~/.local/share/nautilus-python/extensions/,
# ensure you have python-nautilus package, restart Nautilus, and enjoy :)
#
# This script was written by cra0zy and is released to the public domain

from gi import require_version
require_version('Gtk', '3.0')
require_version('Nautilus', '3.0')
from gi.repository import Nautilus, GObject
from subprocess import call
import os

# path to subliminal
SUBLIMINAL = 'subliminal'

class SubliminalDownloadExtension(GObject.GObject, Nautilus.MenuProvider):

    def download_subtitle(self, menu, files):
        for file in files:
            filepath = file.get_location().get_path()
            safepath = '"' + filepath + '" '

            # Skip if one is a directory
            if os.path.isdir(filepath):
                continue

            call(f'{SUBLIMINAL} download -l en {safepath} &', shell=True)

    def get_file_items(self, window, files):
        item = Nautilus.MenuItem(
            name='SubtitleDownload',
            label='Download Subtitle',
            tip='Downloads Subtitle using Subliminal'
        )
        item.connect('activate', self.download_subtitle, files)

        return [item]

    def get_background_items(self, window, file_):
        item = Nautilus.MenuItem(
            name='SubtitleDownloadBackground',
            label='Download Subtitle',
            tip='Downloads Subtitle using Subliminal'
        )
        item.connect('activate', self.download_subtitle, [file_])

        return [item]
