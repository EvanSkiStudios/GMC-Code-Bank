// Initialize defaults...
function splash_initialize() {
  globalvar splash_get_main, splash_get_caption, splash_get_fullscreen,
  splash_get_border, splash_get_volume;

  splash_get_main = true;
  splash_get_caption = "";
  splash_get_fullscreen = false;
  splash_get_border = true;
  splash_get_volume = 100;
}

// splash_set_main(main) Indicated whether the splash screen must be
// shown in the main game window (true, default) or in a separate window
// (false).

function splash_set_main(main) {
  splash_get_main = main;
}

// splash_set_caption(cap) Sets the caption for the splash window. This
// only has effect when is a separate splash window is used. Default the
// empty string is used.

function splash_set_caption(cap) {
  splash_get_caption = cap;
}

// splash_set_fullscreen(full) Indicates whether to use a full screen
// window or not. This only has effect when is a separate splash window is
// used. Default a normal window is used.

function splash_set_fullscreen(full) {
  splash_get_fullscreen = full;
}

// splash_set_border(border) Indicates whether the window should have a
// border. This only has effect when is a separate normal splash window is
// used. Default a border is used.

function splash_set_border(border) {
  splash_get_border = border;
}

// splash_set_volume(vol) Indicates the percent of volume the splash
// screen is to have if video or audio. Default the value is 100.

function splash_set_volume(vol) {
  splash_get_volume = vol;
}

// splash_show_video(fname,loop) Shows a video splash screen. fname is the
// name of the video file. loop indicates whether to loop the video.

function splash_show_video(fname, loop) {
  globalvar video;
  var wid, wstr, hstr, xstr, ystr, size, pstn, geom;

  if (splash_get_main) {
    if (os_type == os_macosx) {
      wid = window_get_contentview(string(int64(window_handle())));
    } else { wid = string(int64(window_handle())); }
  } else { wid = "-1"; }

  if (splash_get_fullscreen) splash_get_fullscreen = "yes";
  else splash_get_fullscreen = "no";

  if (splash_get_border) splash_get_border = "yes";
  else splash_get_border = "no";

  if (splash_get_main) splash_get_main = "no";
  else splash_get_main = "yes";

  if (loop) loop = "yes";
  else loop = "no";

  wstr = string(window_get_width());
  hstr = string(window_get_height());
  xstr = string(window_get_x());
  ystr = string(window_get_y());
  size = wstr + "x" + hstr;
  pstn = xstr + "+" + ystr;
  geom = size + "+" + pstn;

  video = video_add(fname);
  video_set_option_string(video, "volume", string(splash_get_volume));
  video_set_option_string(video, "input-default-bindings", "no");
  video_set_option_string(video, "title", splash_get_caption);
  video_set_option_string(video, "fs", splash_get_fullscreen);
  video_set_option_string(video, "border", splash_get_border);
  video_set_option_string(video, "keepaspect-window", "no");
  video_set_option_string(video, "taskbar-progress", "no");
  video_set_option_string(video, "ontop", splash_get_main);
  video_set_option_string(video, "geometry", geom);
  video_set_option_string(video, "config", "no");
  video_set_option_string(video, "loop", loop);
  video_set_option_string(video, "osc", "no");
  video_set_option_string(video, "wid", wid);

  video_play(video);
  var canpause = true;
  if (os_type == os_windows) {
    while (video_is_playing(video)) {
      /* handle video pause and stop actions here */
      /* use keyboard_check_direct for pause/stop */
      /* you can use window_has_focus in if check */
      /* keyboard_check_direct is broken on linux */
      /* use async video playback for linux input */
      // example:
      if (window_has_focus()) {
        if (keyboard_check_direct(vk_escape)) {
          video_stop(video);
        } else if (keyboard_check_direct(vk_space)) {
          if (canpause) {
            video_pause(video);
            canpause = false;
          }
        } else {
          canpause = true;
        }
      }
    }
    video_delete(video);
  }
}

// Process Pause/Stop input on non-Windows
function splash_update() {
  if (os_type != os_windows) {
    if (video_exists(video)) {
      if (keyboard_check_pressed(vk_escape)) {
        video_stop(video);
        video_delete(video);
      } else if (keyboard_check_pressed(vk_space)) {
        video_pause(video);
      } else if (!video_is_playing(video)) {
        video_delete(video);
      }
    }
  }
}