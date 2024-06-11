{
  config,
  inputs,
  ...
}: {
  services.avizo.enable = true;
  services.avizo.settings = {
    default = {
      background = "rgba(${config.scheme.base01-rgb-r}, ${config.scheme.base01-rgb-g}, ${config.scheme.base01-rgb-b}, 0.6)";
      border-color = "#${config.scheme.base09}";
      bar-fg-color = "#${config.scheme.base06}";
      border-width = 2;
    };
  };
}
