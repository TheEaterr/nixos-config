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
      border-color = "#${config.hexAccent}";
      bar-fg-color = "#${config.hexAccent}";
      border-width = 2;
      time = 0.5;
    };
  };
}
