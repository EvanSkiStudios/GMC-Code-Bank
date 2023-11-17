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

#include <X11/Xlib.h>
#include <X11/Xatom.h>

#include <iostream>
#include <string>

#include "lodepng.h"

static inline unsigned int nlpo2dc(unsigned int x) {
  x--;
  x |= x >> 1;
  x |= x >> 2;
  x |= x >> 4;
  x |= x >> 8;
  return x | (x >> 16);
}

void XSetIcon(Display *display, Window window, const char *icon) {
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