#include <thread>
#include <chrono>
#include <iostream>
#include <windows.h>

using std::string;
using std::cout;
using std::endl;

int main() {
  RECT rc;
  std::this_thread::sleep_for (std::chrono::seconds(1));
  while (true) {
    if ((GetKeyState(VK_LBUTTON) & 0x100) != 0) {
      break;
    }
  }
  std::this_thread::sleep_for (std::chrono::seconds(1));
  HWND hwnd = GetForegroundWindow();
  GetWindowRect(hwnd, &rc);
  HDC hdcScreen = GetDC(NULL);
  HDC hdc = CreateCompatibleDC(hdcScreen);
  HBITMAP hbmp = CreateCompatibleBitmap(hdcScreen, rc.right - rc.left, rc.bottom - rc.top);
  SelectObject(hdc, hbmp);
  PrintWindow(hwnd, hdc, 0);
  OpenClipboard(NULL);
  EmptyClipboard();
  SetClipboardData(CF_BITMAP, hbmp);
  CloseClipboard();
  DeleteDC(hdc);
  DeleteObject(hbmp);
  ReleaseDC(NULL, hdcScreen);
  cout << "successfully copied to clipboard, please paste it into 'mspaint'" << endl;
  return 0;
}