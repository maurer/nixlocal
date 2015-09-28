{ rxvt_unicode, xmobar, dmenu, firefox, chromium, mplayer, pavucontrol,
  pianobar, buildEnv }:

buildEnv rec {
  name = "gui";
  ignoreCollisions = true;
  paths = [
    rxvt_unicode
    xmobar
    dmenu
    firefox
    chromium
    mplayer
    pavucontrol
    pianobar
  ];
}
