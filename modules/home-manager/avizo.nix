{
  config,
  inputs,
  themeParams,
  ...
}: {
  services.avizo.enable = true;
  services.avizo.settings = {
    default = {
      background = "rgba(${config.scheme.base01-rgb-r}, ${config.scheme.base01-rgb-g}, ${config.scheme.base01-rgb-b}, 0.6)";
      border-color = "#${config.base16Accent}";
      bar-fg-color = "#${config.base16Accent}";
      border-width = 2;
      time = 0.5;
    };
  };
}
