/*

 MIT License

 Copyright © 2019 Samuel Venable
 Copyright © 2019 Robert B. Colton

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

// USAGE: xtransientfor [window] [command] [title] [icon] [xpos] [ypos] [width] [height]
// [window]: the window id of the window whose command's active window is transient for.
// [command]: the command line to execute and read output from; assumes window creation.
// [title]: the title bar caption text that the command line's active window changes to.
// [icon]: the png icon file which is to be painted on the command line's active window.
// [xpos] [ypos] [width] [height]: x/y position, width, and height of the active window.

// NOTE: xtransientfor waits for the application specified in [command] to open at least
// one window before it will do anything else; this window must be owned by a process id
// which is stored in the _NET_WM_PID atom. If the command launches an executable that's
// not setting the _NET_WM_PID to its own process id on creation, xtransientfor will not
// work; this is done to make sure the window whose properties that are being changed is
// a window that belongs to a child process. the title, icon, size, and x/y pos which is
// specified by xtransientfor's command line parameters can only modify that one window.
// use "center" for x/y position to center the window on your default monitor's display.
// [title], [icon], [xpos], [ypos], [width], and [height] can all optionally be omitted.

#include <X11/Xlib.h>
#include <X11/Xatom.h>
#include <X11/Xutil.h>

#include <sys/wait.h>
#include <unistd.h>
#include <signal.h>

#ifdef __linux__
#include <proc/readproc.h>
#else // BSD
#include <sys/user.h>
#include <libutil.h>
#endif

#include <thread>
#include <chrono>

#include <cstring>

#include <iostream>
#include <string>

#include "lodepng.h"

using std::string;

static inline unsigned nlpo2dc(unsigned x) {
  x--;
  x |= x >> 1;
  x |= x >> 2;
  x |= x >> 4;
  x |= x >> 8;
  return x | (x >> 16);
}

static inline void XSetIcon(Display *display, Window window, const char *icon) {
  XSynchronize(display, True);
  Atom property = XInternAtom(display, "_NET_WM_ICON", True);

  unsigned char *data = nullptr;
  unsigned pngwidth, pngheight;
  unsigned error = lodepng_decode32_file(&data, &pngwidth, &pngheight, icon);
  if (error) return;

  unsigned
    widfull = nlpo2dc(pngwidth) + 1,
    hgtfull = nlpo2dc(pngheight) + 1,
    ih, iw;

  const int bitmap_size = widfull * hgtfull * 4;
  unsigned char *bitmap = new unsigned char[bitmap_size]();

  unsigned i = 0;
  unsigned elem_numb = 2 + pngwidth * pngheight;
  unsigned long *result = new unsigned long[elem_numb]();

  result[i++] = pngwidth;
  result[i++] = pngheight;
  for (ih = 0; ih < pngheight; ih++) {
    unsigned tmp = ih * widfull * 4;
    for (iw = 0; iw < pngwidth; iw++) {
      bitmap[tmp + 0] = data[4 * pngwidth * ih + iw * 4 + 2];
      bitmap[tmp + 1] = data[4 * pngwidth * ih + iw * 4 + 1];
      bitmap[tmp + 2] = data[4 * pngwidth * ih + iw * 4 + 0];
      bitmap[tmp + 3] = data[4 * pngwidth * ih + iw * 4 + 3];
      result[i++] = bitmap[tmp + 0] | (bitmap[tmp + 1] << 8) | (bitmap[tmp + 2] << 16) | (bitmap[tmp + 3] << 24);
      tmp += 4;
    }
  }

  XChangeProperty(display, window, property, XA_CARDINAL, 32, PropModeReplace, (unsigned char *)result, elem_numb);
  XFlush(display);
  delete[] result;
  delete[] bitmap;
  delete[] data;
}

static inline Window XGetActiveWindow(Display *display) {
  unsigned long window;
  unsigned char *prop;

  Atom actual_type, filter_atom;
  int actual_format, status;
  unsigned long nitems, bytes_after;

  int screen = XDefaultScreen(display);
  window = RootWindow(display, screen);

  filter_atom = XInternAtom(display, "_NET_ACTIVE_WINDOW", True);
  status = XGetWindowProperty(display, window, filter_atom, 0, 1000, False, AnyPropertyType, &actual_type, &actual_format, &nitems, &bytes_after, &prop);

  unsigned long long_property = prop[0] + (prop[1] << 8) + (prop[2] << 16) + (prop[3] << 24);
  XFree(prop);

  return (Window)long_property;
}

static inline pid_t XGetActiveProcessId(Display *display) {
  unsigned long window = XGetActiveWindow(display);
  unsigned char *prop;

  Atom actual_type, filter_atom;
  int actual_format, status;
  unsigned long nitems, bytes_after;

  filter_atom = XInternAtom(display, "_NET_WM_PID", True);
  status = XGetWindowProperty(display, window, filter_atom, 0, 1000, False, AnyPropertyType, &actual_type, &actual_format, &nitems, &bytes_after, &prop);

  unsigned long long_property = prop[0] + (prop[1] << 8) + (prop[2] << 16) + (prop[3] << 24);
  XFree(prop);

  return (pid_t)long_property;
}

static inline bool WaitForChildPidOfPidToExist(pid_t pid, pid_t ppid) {
  while (pid != ppid) {
    if (pid <= 1) break;
    #ifdef __linux__ // Linux
    proc_t proc_info;
    memset(&proc_info, 0, sizeof(proc_info));
    PROCTAB *pt_ptr = openproc(PROC_FILLSTATUS | PROC_PID, &pid);
    if (readproc(pt_ptr, &proc_info) != 0) { 
      pid = proc_info.ppid;
    }
    closeproc(pt_ptr);
    #else // BSD
    struct kinfo_proc *proc_info = kinfo_getproc(pid);
    if (proc_info) {
      pid = proc_info->ki_ppid;
    }
    free(proc_info);
    #endif
  }
  return (pid == ppid);
}

static inline bool file_exists(const char *fname) {
  return (access(fname, F_OK) != -1);
}

static inline string filename_name(string fname) {
  size_t fp = fname.find_last_of("/");
  return fname.substr(fp + 1);
}

static inline string filename_ext(string fname) {
  fname = filename_name(fname);
  size_t fp = fname.find_last_of(".");
  if (fp == string::npos)
   return "";
  return fname.substr(fp);
}

int main(int argc, const char **argv) {
  string helparg = argv[1] ? argv[1] : "--help";

  if (argc == 2 && helparg == "--help") {
    std::cout << "USAGE: xtransientfor [window] [command] [title] [icon] [xpos] [ypos] [width] [height]" << std::endl;
    std::cout << "[window]: the window id of the window whose command's active window is transient for." << std::endl;
    std::cout << "[command]: the command line to execute and read output from; assumes window creation." << std::endl;
    std::cout << "[title]: the title bar caption text that the command line's active window changes to." << std::endl;
    std::cout << "[icon]: the png icon file which is to be painted on the command line's active window." << std::endl;
    std::cout << "[xpos] [ypos] [width] [height]: x/y position, width, and height of the active window." << std::endl;
    std::cout << "                                                                                     " << std::endl;
    std::cout << "NOTE: xtransientfor waits for the application specified in [command] to open at least" << std::endl;
    std::cout << "one window before it will do anything else; this window must be owned by a process id" << std::endl;
    std::cout << "which is stored in the _NET_WM_PID atom. If the command launches an executable that's" << std::endl;
    std::cout << "not setting the _NET_WM_PID to its own process id on creation, xtransientfor will not" << std::endl;
    std::cout << "work; this is done to make sure the window whose properties that are being changed is" << std::endl;
    std::cout << "a window that belongs to a child process. the title, icon, size, and x/y pos which is" << std::endl;
    std::cout << "specified by xtransientfor's command line parameters can only modify that one window." << std::endl;
    std::cout << "use 'center' for x/y position to center the window on your default monitor's display." << std::endl;
    std::cout << "[title], [icon], [xpos], [ypos], [width], and [height] can all optionally be omitted." << std::endl;
  }

  if (argc >= 3 && argc <= 9) {
    char *buffer = NULL;
    size_t buffer_size = 0;
    string str_buffer;

    FILE *file = popen(argv[2], "r");
    pid_t ppid = getpid();
    pid_t pid = 0;

    if ((pid = fork()) == 0) {
      Display *display = XOpenDisplay(NULL);
      while (!WaitForChildPidOfPidToExist(XGetActiveProcessId(display), ppid));
      Window window = XGetActiveWindow(display);

      Window parent = (Window)strtoul(argv[1], NULL, 10);
      Atom window_type = XInternAtom(display, "_NET_WM_WINDOW_TYPE", True);
      Atom dialog_type = XInternAtom(display, "_NET_WM_WINDOW_TYPE_DIALOG", True);
      XChangeProperty(display, window, window_type, XA_ATOM, 32, PropModeReplace, (unsigned char *)&dialog_type, 1);

      XSetTransientForHint(display, window, parent);
      string argv3 = argv[3] ? argv[3] : "";

      if (argc >= 4 && argv3 != "") {
        Atom atom_name = XInternAtom(display,"_NET_WM_NAME", True);
        Atom atom_utf_type = XInternAtom(display,"UTF8_STRING", True);
        XChangeProperty(display, window, atom_name, atom_utf_type, 8, PropModeReplace, (unsigned char *)argv[3], strlen(argv[3]));
      }

      if (argc >= 5 && argv[4] != NULL && file_exists(argv[4]) && filename_ext(argv[4]) == ".png")
        XSetIcon(display, window, argv[4]);
 
      string argv5 = argv[5] ? argv[5] : "center";
      string argv6 = argv[6] ? argv[6] : "center";
 
      if (argc >= 7) {
        int xpos = (int)strtol(argv[5], NULL, 10);
        int ypos = (int)strtol(argv[6], NULL, 10);
        XMoveWindow(display, window, xpos, ypos);
      }
      
      if (argc <= 5 || (argc <= 8 && (argv5 == "center" || argv6 == "center"))) {
        Window child, root = DefaultRootWindow(display); 
        int x0, y0, x1, y1, x2, y2; unsigned w1, h1, w2, h2, border_width, depth;
        XTranslateCoordinates(display, parent, root, 0, 0, &x0, &y0, &child);
        XGetGeometry(display, parent, &root, &x2, &y2, &w2, &h2, &border_width, &depth);
        XGetGeometry(display, window, &root, &x1, &y1, &w1, &h1, &border_width, &depth);
        int xpos = (x0 - x2) + ((w2 - w1) / 2);
        int ypos = (y0 - y2) + ((h2 - h1) / 2);
        XMoveWindow(display, window, xpos, ypos);
      }
 
      if (argc == 9) {
        XSizeHints *hints = XAllocSizeHints(); long supplied;
        XGetWMNormalHints(display, window, hints, &supplied);

        unsigned w1 = (unsigned)strtoul(argv[7], NULL, 10);
        unsigned h1 = (unsigned)strtoul(argv[8], NULL, 10);

        if (hints->min_width != 0 && w1 < hints->min_width) w1 = hints->min_width;
        if (hints->max_width != 0 && w1 > hints->max_width) w1 = hints->max_width;
        if (hints->min_height != 0 && h1 < hints->min_height) h1 = hints->min_height;
        if (hints->max_height != 0 && h1 > hints->max_height) h1 = hints->max_height;

        XResizeWindow(display, window, w1, h1);
   
        if (argv5 == "center" || argv6 == "center") {
          Window child, root = DefaultRootWindow(display);
          int x0, y0, x1, y1, x2, y2; unsigned w2, h2, border_width, depth;
          XTranslateCoordinates(display, parent, root, 0, 0, &x0, &y0, &child);
          XGetGeometry(display, parent, &root, &x2, &y2, &w2, &h2, &border_width, &depth);
          XGetGeometry(display, window, &root, &x1, &y1, &w1, &h1, &border_width, &depth);
          int xpos = (x0 - x2) + ((w2 - w1) / 2);
          int ypos = (y0 - y2) + ((h2 - h1) / 2);
          XMoveWindow(display, window, xpos, ypos);
        }

        XFree(hints);
      }

      XCloseDisplay(display);
      exit(0);
    }

    while (getline(&buffer, &buffer_size, file) != -1)
      str_buffer += buffer;

    std::cout << str_buffer;
    free(buffer);
    pclose(file);

    kill(pid, SIGTERM);
    bool died = false;

    for (unsigned i = 0; !died && i < 5; i++) {
      int status; 
      std::this_thread::sleep_for(std::chrono::seconds(1));
      if (waitpid(pid, &status, WNOHANG) == pid) died = true;
    }

    if (!died) kill(pid, SIGKILL);
  }
}