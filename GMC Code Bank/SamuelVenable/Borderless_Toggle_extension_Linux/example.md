```gml
/// @desc Global Mouse Left Pressed Event:
var hwnd = window_handle(); // Get GameMaker's Runner Window ID
var show = !window_get_showborder(hwnd); // Get Destination Border State
var clientx = window_get_x(); // Get the Current Window X Position
var clienty = window_get_y(); // Get the Current Window Y Position
window_set_showborder(hwnd, show, clientx, clienty); // Set Border State
```

GameMaker Studo 2 Result:  

 (KDE neon 5.16.4)  
![](https://i.imgur.com/CTV3A6b.gif)    

(Lubuntu 18.04.2 LTS)  
![](https://i.imgur.com/rwpD476.gif )  

 (Xubuntu 18.04.2 LTS)  
![](https://i.imgur.com/eB4OUfk.gif)  

 (Ubuntu 18.04.2 LTS)  
![](https://i.imgur.com/REAFb9B.gif)  

Needless to say, it also worked in Kubuntu 18.04.2 LTS, but I don't have screenshots for that.


To expand on my previous post, KDE's (and LXQt's) Window Manager, KWin, has a lot of oddities that make it behave and react different to code that separate it from the consistent behaviors of most other Window Managers, including GNOME, XFCE, and LXDE. One of these oddities, as demonstrated in my previous post, getting a window's client area x/y position relative to the titlebar's x/y position, requires the use of XQueryTree, but, it will need to be used differently depending on whether running under KWin or some other Window Manager. This requires checking in code whether KWin is the current Window Manager running, and to do this, you may use the following code:

```cpp
#include <X11/Xlib.h>
// simple helper function to determine whether kwin is running.
// do not call this from GM without changing the return to double
// and exporting the function properly so that it will be recognized.
bool kwin_running() {
  Display *d = XOpenDisplay(NULL);
  // don't change the last argument to false or bad stuff will happen.
  Atom aKWinRunning = XInternAtom(d, "KWIN_RUNNING", True);
  bool bKWinRunning = (aKWinRunning != None);
  XCloseDisplay(d);
  return bKWinRunning;
}
```

The above code could also be used in combination with my [Dialog Module](https://marketplace.gamemaker.io/assets/6621/dialog-module) extension, so that if (kwin_running() == true), use KDE widgets with KDialog, otherwise use GTK+ widgets with Zenity, if you were to export the above function to a library with the double return type. As I just explained, you could then do this, for example:

```cpp
if (kwin_running() == true)
  wigdet_set_system("KDialog");
else
  wigdet_set_system("Zenity");
```

Special thanks to the KDE community forum member, kde-cfeck, for helping me out with this: https://forum.kde.org/viewtopic.php?f=305&t=161880