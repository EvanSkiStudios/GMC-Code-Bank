/*

 MIT License

 Copyright © 2019 Samuel Venable

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.

*/

#include "ShowBorder.h"
#include <X11/Xlib.h>
#include <climits>

typedef struct {
  unsigned long flags;
  unsigned long functions;
  unsigned long decorations;
  long inputMode;
  unsigned long status;
} Hints;

double window_get_showborder(void *hwnd) {
  Atom type;
  int format;
  unsigned long bytes;
  unsigned long items;
  unsigned char *data = NULL;
  bool ret = true;
  Display *d = XOpenDisplay(NULL);
  Window w = (Window)hwnd;
  Atom property = XInternAtom(d, "_MOTIF_WM_HINTS", False);
  if (XGetWindowProperty(d, w, property, 0, LONG_MAX, False, AnyPropertyType, &type, &format, &items, &bytes, &data) == Success && data != NULL) {
    Hints *hints = (Hints *)data;
    ret = hints->decorations;
    XFree(data);
  }
  XCloseDisplay(d);
  return ret;
}

double window_set_showborder(void *hwnd, double show, double clientx, double clienty) {
  Display *d = XOpenDisplay(NULL);
  Window w = (Window)hwnd;
  Atom aKWinRunning = XInternAtom(d, "KWIN_RUNNING", True);
  bool bKWinRunning = (aKWinRunning != None);
  XWindowAttributes wa;
  Window root, parent, *child; uint children;
  XWindowAttributes pwa;
  for (;;) {
    XGetWindowAttributes(d, w, &wa);
    XQueryTree(d, w, &root, &parent, &child, &children);
    XGetWindowAttributes(d, parent, &pwa);
    if ((bKWinRunning ? pwa.x : wa.x) || (bKWinRunning ? pwa.y : wa.y) || !window_get_showborder(hwnd))
      break;
  }
  static const int xoffset = bKWinRunning ? pwa.x : wa.x;
  static const int yoffset = bKWinRunning ? pwa.y : wa.y;
  Hints hints;
  Atom property = XInternAtom(d, "_MOTIF_WM_HINTS", False);
  hints.flags = 2;
  hints.decorations = show;
  XChangeProperty(d, w, property, property, 32, PropModeReplace, (unsigned char *)&hints, 5);
  int xpos = show ? clientx - xoffset : clientx;
  int ypos = show ? clienty - yoffset : clienty;
  XMoveResizeWindow(d, w, xpos, ypos, bKWinRunning ? wa.width : wa.width + xoffset, bKWinRunning ? wa.height : wa.height + yoffset);
  XCloseDisplay(d);
  return 0;
}