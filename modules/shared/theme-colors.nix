{lib, ...}: {
  options.theme.light = {
    flavor = lib.mkOption {
      type = lib.types.str;
      default = "latte";
    };

    accent = lib.mkOption {
      type = lib.types.str;
      default = "peach";
    };
  };
  options.theme.dark = {
    flavor = lib.mkOption {
      type = lib.types.str;
      default = "mocha";
    };

    accent = lib.mkOption {
      type = lib.types.str;
      default = "peach";
    };
  };

  config.theme = {
    light = {
      flavor = "latte";
      accent = "peach";
    };
    dark = {
      flavor = "mocha";
      accent = "peach";
    };
  };
}
