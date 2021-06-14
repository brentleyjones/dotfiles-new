#!/usr/bin/env python3

from FinderSidebarEditor import FinderSidebar
from pathlib import Path

sidebar = FinderSidebar()

if not sidebar.get_index_from_name("Developer"):
    sidebar.add(str(Path.home()) + "/Developer")
    if sidebar.get_index_from_name("Desktop"):
        sidebar.move("Developer", "Desktop")
    else:
        sidebar.move("Developer", "Applications")
