Needs [this extension](https://forum.yoyogames.com/index.php?threads/video-player-for-windows-and-ubuntu.77882/).

Remember from GameMaker 8.1 splash_show_video(fname, loop)?
Example...

Create Event:
```gml
if (os_type == os_macosx) {
  /* macOS-specific instructions for building & running games */   

  // Backspace the signing identity of your mac app to skip code
  // signing; doing so will allow you to move the necessary libs
  // to the correct place in your mac bundle. After building the
  // game, you will need to move ALL *.dylib files in the *.app,
  // EXCEPT "libmpv.1.dylib" and "libvidplayer.dylib" from *.app
  // YouAppBundle.app/Contents/Resources to Contents/Frameworks.
  // After you have moved these files to your frameworks folder,
  // you may then codesign your app manually, and open your app.

  // install libmpv on Mac OS X
  // look at macOS Game Options
  // disable filesystem sandbox

  var src, dst;
  dst = "/usr/local/opt/mpv";
  directory_create(dst);
  dst = "/usr/local/opt/mpv/lib";
  directory_create(dst);
  src = working_directory;
  file_copy(src + "/libmpv.1.dylib",
    dst + "/libmpv.1.dylib");
}

// requirement: any video file supported by ffmpeg & mpv media player
// see online manual for option strings https://mpv.io/manual/stable/
// video_set_option_string() wraps the mpv_set_option_string function

// Ubuntu packages install needed:
// sudo apt-get install libmpv-dev

// Initialize defaults...
splash_initialize();

// splash_set_main(main) Indicated whether the splash screen must be
// shown in the main game window (true, default) or in a separate window
// (false).

splash_set_main(true);

// splash_set_caption(cap) Sets the caption for the splash window. This
// only has effect when is a separate splash window is used. Default the
// empty string is used.

splash_set_caption(window_get_caption());

// splash_set_fullscreen(full) Indicates whether to use a full screen
// window or not. This only has effect when is a separate splash window is
// used. Default a normal window is used.

splash_set_fullscreen(window_get_fullscreen());

// splash_set_border(border) Indicates whether the window should have a
// border. This only has effect when is a separate normal splash window is
// used. Default a border is used.

splash_set_border(true);

// splash_set_volume(vol) Indicates the percent of volume the splash
// screen is to have if video or audio. Default the value is 100.

splash_set_volume(100);

// splash_show_video(fname,loop) Shows a video splash screen. fname is the
// name of the video file. loop indicates whether to loop the video.

splash_show_video(working_directory + "example.webm", false);
```

Step Event:
```gml
// Process Pause/Stop input on non-Windows
splash_update();

if (!video_exists(video)) {
  // End the game when video playback is ogre...
  // ...it's never ogre...
  // ...shrek is love...
  // ...shrek is life...
  game_end();
}
```

