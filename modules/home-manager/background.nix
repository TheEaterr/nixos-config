{outputs, ...}: {
  home.file."background_3x2.jpg".source = outputs.assets.background_3x2;
  home.file."lockscreen_3x2.png".source = outputs.assets.lockscreen_3x2;
}
