Change your Linux icon to one larger than YoYo's forced size of 64x64. All resolutions supported, even ones of a non-square aspect ratio. Requires lodepng. Can also be used to make animated window icons, if you are ok with loading/unloading separate PNG files for each individual animation frame.

To expand upon the code in my previous post, here is a Linux command line application that can be used from your game maker game using the code found in the OP:

xtransientfor.cpp

Usage is mentioned in the code comments directly below the copyright and license information. Requires lodepng.

I originally created this as a patch for a program called zenity because it has two features that are broken for the file and color picker dialogs I had to patch up - setting the title bar icon and making the dialog reliably stay on top of the game window. but it can be used with virtually any command line program, not just zenity. For example, you could launch any program and make it stay on top of your game window during execution to similate the concept of a modal dialog - except the possibilities are endless because you may use any exe you want as the dialog, pass parameters to it and even read the output to your game. Optionally, for programs that support it, you may specify a PNG icon to change the target executable's icon too - the icon that will show on the title bar in some distro's and the task manager.