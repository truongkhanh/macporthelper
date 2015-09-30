# macporthelper

This is a Xcode plug-in created while we are porting Visual Studio C++ Project to XCode Project. There are 4 functions provided which are located in the Edit menu.
* Checkout TFS: Check out the current file to edit. Remember to install [Team Explorer Everywhere](https://www.visualstudio.com/en-us/products/team-explorer-everywhere-vs.aspx)
* Fix Header Path: Auto fix the including header paths by replacing "\" with "/"
* Print the full path of the current file on the Terminal
* Open a terminal on the folder containing the current file

To run the project, please open "macporthelper.xcworkspace".

You can easily set the short cut for the menu item by:
* Go to "System Preferences, Keyboard" and select "Shortcuts" tab. Then select the "App Shortcuts" category on the left panel and create a new shortcut.
* Select "Xcode" for "Application". For "Menu Title", type correctly the menu item under Edit, e.g., "Checkout TFS" and press the shortcut you want to assign.
