{
  lib,
  inputs,
  ...
}: {
  options.theme.light = {
    flavor = lib.mkOption {
      type = lib.types.str;
      default = "latte";
    };

    accent = lib.mkOption {
      type = lib.types.str;
      default = "peach";
    };

    base16Accent = lib.mkOption {
      type = lib.types.str;
      default = "base09";
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

    base16Accent = lib.mkOption {
      type = lib.types.str;
      default = "base09";
    };
  };

  options.theme.schemes = {
    light = lib.mkOption {
      type = lib.types.str;
      default = "";
    };

    dark = lib.mkOption {
      type = lib.types.str;
      default = "";
    };
  };

  options.theme = {
    variant = lib.mkOption {
      type = lib.types.str;
      default = "dark";
    };
  };

  config.theme = let
    accent2Base16 = {
      rosewater = "base06";
      lavender = "base07";
      red = "base08";
      peach = "base09";
      yellow = "base0A";
      green = "base0B";
      teal = "base0C";
      blue = "base0D";
      mauve = "base0E";
      flamingo = "base0F";

      # These have no direct base16 equivalent
      maroon = "base08";
      pink = "base0F";
      sapphire = "base0C";
      sky = "base0D";
    };

    lightFlavor = "latte";
    darkFlavor = "mocha";
    lightAccent = "peach";
    darkAccent = "peach";
  in {
    light = {
      flavor = lightFlavor;
      accent = lightAccent;
    };
    dark = {
      flavor = darkFlavor;
      accent = darkAccent;
    };

    light.base16Accent = accent2Base16.${lightAccent};
    dark.base16Accent = accent2Base16.${darkAccent};

    schemes = {
      light = "${inputs.tt-schemes}/base16/catppuccin-${lightFlavor}.yaml";
      dark = "${inputs.tt-schemes}/base16/catppuccin-${darkFlavor}.yaml";
    };
  };
}
