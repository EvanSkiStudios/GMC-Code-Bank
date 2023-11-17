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

#include <windows.h>

#include <cwchar>
#include <vector>
#include <string>

#include "lodepng.h"

using std::basic_string;
using std::wstring;
using std::string;
using std::vector;
using std::size_t;

#define EXPORTED_FUNCTION extern "C" __declspec(dllexport)

static inline wstring widen(string tstr) {
  size_t wchar_count = tstr.size() + 1;
  vector<wchar_t> buf(wchar_count);
  return wstring{ buf.data(), (size_t)MultiByteToWideChar(CP_UTF8, 0, tstr.c_str(), -1, buf.data(), (int)wchar_count) };
}

static inline string narrow(wstring wstr) {
  int nbytes = WideCharToMultiByte(CP_UTF8, 0, wstr.c_str(), (int)wstr.length(), NULL, 0, NULL, NULL);
  vector<char> buf(nbytes);
  return string{ buf.data(), (size_t)WideCharToMultiByte(CP_UTF8, 0, wstr.c_str(), (int)wstr.length(), buf.data(), nbytes, NULL, NULL) };
}

static inline bool file_exists(string fname) {
  DWORD file_attr;
  wstring wstr_fname = widen(fname);
  file_attr = GetFileAttributesW(wstr_fname.c_str());
  return (file_attr != INVALID_FILE_ATTRIBUTES && !(file_attr & FILE_ATTRIBUTE_DIRECTORY));
}

EXPORTED_FUNCTION double clipboard_has_imgdata() {
  return IsClipboardFormatAvailable(CF_BITMAP);
}

EXPORTED_FUNCTION double clipboard_load_pngfile(char *fname) {
  if (!file_exists(fname)) return 0;
  unsigned char *src = nullptr;
  unsigned width, height;

  lodepng_decode32_file(&src, &width, &height, fname);

  std::vector<unsigned char> dst;
  int n = width * height * 4;
  dst.resize(n);

  int i = 0;
  for (int y = 0; y < (int)height; y++) {
   for (int x = 0; x < (int)width; x++) {
     int base = (y * width + x) * 4;
     if (src[base + 3] == 0) i++;
   }
  }

  int j = 0;
  for (int y = 0; y < (int)height; y++) {
   for (int x = 0; x < (int)width; x++) {
     int base = (y * width + x) * 4;
     dst[j++] = src[base + 2];
     dst[j++] = src[base + 1];
     dst[j++] = src[base];
     dst[j++] = (i != n / 4) ? src[base + 3] : 255;
   }
  }

  HBITMAP hBitmap = CreateBitmap(width, height, 1, 32, dst.data());

  OpenClipboard(NULL);
  EmptyClipboard();
  SetClipboardData(CF_BITMAP, hBitmap);
  CloseClipboard();

  CloseHandle(hBitmap);
  free(src);
  return 0;
}

EXPORTED_FUNCTION double clipboard_dump_pngfile(char *fname) {
  if (!clipboard_has_imgdata()) return 0;
  OpenClipboard(NULL);
  HBITMAP hBitmap = (HBITMAP)GetClipboardData(CF_BITMAP);
  CloseClipboard();

  BITMAPINFOHEADER bih = { 0 };
  bih.biSize = sizeof(BITMAPINFOHEADER);

  HDC hdc = GetDC(NULL);
  GetDIBits(hdc, hBitmap, 0, (UINT)bih.biHeight, NULL, (BITMAPINFO *)&bih, DIB_RGB_COLORS);
  if (bih.biBitCount <= 8) GetDIBits(hdc, hBitmap, 0, (UINT)bih.biHeight, NULL, (BITMAPINFO *)&bih, DIB_RGB_COLORS);

  unsigned char *src = (unsigned char *)malloc(bih.biWidth * bih.biHeight * 4);
  memset(src, 0, bih.biWidth * bih.biHeight * 4);

  GetDIBits(hdc, hBitmap, 0, (UINT)bih.biHeight, src, (BITMAPINFO *)&bih, DIB_RGB_COLORS);
  ReleaseDC(NULL, hdc);

  std::vector<unsigned char> dst;
  int n = bih.biWidth * bih.biHeight * 4;
  dst.resize(n);

  int i = 0;
  for (int y = bih.biHeight - 1; y >= 0; y--) {
   for (int x = 0; x < bih.biWidth; x++) {
     int base = (y * bih.biWidth + x) * 4;
     if (src[base + 3] == 0) i++;
   }
  }

  int j = 0;
  for (int y = bih.biHeight - 1; y >= 0; y--) {
   for (int x = 0; x < bih.biWidth; x++) {
     int base = (y * bih.biWidth + x) * 4;
     dst[j++] = src[base + 2];
     dst[j++] = src[base + 1];
     dst[j++] = src[base];
     dst[j++] = (i != n / 4) ? src[base + 3] : 255;
   }
  }

  lodepng::encode(fname, dst, bih.biWidth, bih.biHeight);

  CloseHandle(hBitmap);
  free(src);
  return 0;
}