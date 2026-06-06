Set WshShell = CreateObject("WScript.Shell")
shortcutPath = WshShell.ExpandEnvironmentStrings("%USERPROFILE%") & "\Desktop\Old File Explorer.lnk"

Set shortcut = WshShell.CreateShortcut(shortcutPath)
shortcut.TargetPath = WshShell.ExpandEnvironmentStrings("%WINDIR%") & "\explorer.exe"
shortcut.Arguments = "shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}\5\::{679f85cb-0220-4080-b29b-5540cc05aab6}"
shortcut.Description = "Search your files and folders with the old File Explorer ribbon!"
shortcut.Save

WScript.Echo "Done, the shortcut is located on the desktop and is called ""Old File Explorer"""