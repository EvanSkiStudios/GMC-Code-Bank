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
#include <string>
#include <vector>

using std::basic_string;
using std::wstring;
using std::string;
using std::vector;
using std::size_t;

#define EXPORTED_FUNCTION extern "C" _declspec(dllexport)

static inline wstring widen(string str) {
  const size_t wchar_count = str.size() + 1;
  vector<wchar_t> buf(wchar_count);
  return wstring{ buf.data(), (size_t)MultiByteToWideChar(CP_UTF8, 0, str.c_str(), -1, buf.data(), (int)wchar_count) };
}

static inline string narrow(wstring str) {
  int nbytes = WideCharToMultiByte(CP_UTF8, 0, str.c_str(), (int)str.length(), NULL, 0, NULL, NULL);
  vector<char> buf((size_t)nbytes);
  return string{ buf.data(), (size_t)WideCharToMultiByte(CP_UTF8, 0, str.c_str(), (int)str.length(), buf.data(), nbytes, NULL, NULL) };
}

static inline char *evaluate_shell_helper(char *command) {
  string str_command = command;
  wstring wstr_command = widen(str_command);
  wchar_t cwstr_command[32768];
  wcsncpy_s(cwstr_command, wstr_command.c_str(), 32768);
  BOOL ok = TRUE;
  HANDLE hStdInPipeRead = NULL;
  HANDLE hStdInPipeWrite = NULL;
  HANDLE hStdOutPipeRead = NULL;
  HANDLE hStdOutPipeWrite = NULL;
  SECURITY_ATTRIBUTES sa = { sizeof(SECURITY_ATTRIBUTES), NULL, TRUE };
  ok = CreatePipe(&hStdInPipeRead, &hStdInPipeWrite, &sa, 0);
  if (ok == FALSE) return (char *)"";
  ok = CreatePipe(&hStdOutPipeRead, &hStdOutPipeWrite, &sa, 0);
  if (ok == FALSE) return (char *)"";
  STARTUPINFOW si = { };
  si.cb = sizeof(STARTUPINFOW);
  si.dwFlags = STARTF_USESTDHANDLES;
  si.hStdError = hStdOutPipeWrite;
  si.hStdOutput = hStdOutPipeWrite;
  si.hStdInput = hStdInPipeRead;
  PROCESS_INFORMATION pi = { };
  if (CreateProcessW(NULL, cwstr_command, NULL, NULL, TRUE, CREATE_NO_WINDOW, NULL, NULL, &si, &pi)) {
    while (WaitForSingleObject(pi.hProcess, 5) == WAIT_TIMEOUT) {
      MSG msg;
      if (PeekMessage(&msg, NULL, 0, 0, PM_REMOVE)) {
        TranslateMessage(&msg);
        DispatchMessage(&msg);
      }
    }
    CloseHandle(hStdOutPipeWrite);
    CloseHandle(hStdInPipeRead);
    char buf[4096] = { };
    DWORD dwRead = 0;
    DWORD dwAvail = 0;
    ok = ReadFile(hStdOutPipeRead, buf, 4095, &dwRead, NULL);
    string str_buf = buf; wstring output = widen(str_buf);
    while (ok == TRUE) {
      buf[dwRead] = '\0';
      OutputDebugStringW(output.c_str());
      _putws(output.c_str());
      ok = ReadFile(hStdOutPipeRead, buf, 4095, &dwRead, NULL);
      str_buf = buf; output += widen(str_buf);
    }
    CloseHandle(hStdOutPipeRead);
    CloseHandle(hStdInPipeWrite);
    CloseHandle(pi.hProcess);
    CloseHandle(pi.hThread);
    static string str_output;
    str_output = narrow(output);
    return (char *)str_output.c_str();
  }
  return (char *)"";
}

EXPORTED_FUNCTION char *evaluate_shell(char *command) {
  char *result = evaluate_shell_helper(command);
  size_t len = strlen(result);
  if (len >= 2) {
    if (result[len - 2] == '\r') {
      if (result[len - 1] == '\n') {
        result[len - 2] = '\0';
      }
    }
  }
  return result;
}