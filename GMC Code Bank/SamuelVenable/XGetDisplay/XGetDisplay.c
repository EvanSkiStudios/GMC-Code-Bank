/*

 MIT License

 Copyright © 2020 Samuel Venable

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

#include "XDisplayGetters.h"

#include <stdio.h>
#include <string.h>

int main() {
  char displayWidth[16];
  sprintf(displayWidth, "%d", display_get_width());
  char displayHeight[16];
  sprintf(displayHeight, "%d", display_get_height());
  char displayX[16];
  sprintf(displayX, "%d", display_get_x());
  char displayY[16];
  sprintf(displayY, "%d", display_get_y());
  char cstr[82];
  strcpy(cstr, "Primary Monitor WidthxHeight+X+Y: ");
  strcat(cstr, displayWidth);
  strcat(cstr, "x");
  strcat(cstr, displayHeight);
  strcat(cstr, "+");
  strcat(cstr, displayX);
  strcat(cstr, "+");
  strcat(cstr, displayY);
  puts(cstr);
  return 0;
}