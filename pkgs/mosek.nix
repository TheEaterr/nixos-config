

 { stdenv, lib
, fetchurl
, autoPatchelfHook
}:

stdenv.mkDerivation rec {
  pname = "mosek";
  version = "11.0.28";

  src = fetchurl {
    url = "https://download.mosek.com/stable/${version}/mosektoolslinux64x86.tar.bz2";
    hash = "sha256-vx/8ySIVlp63jzf2jmu1oGtXjRfQjO4xfZMkNLeKpE8=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    stdenv.cc.cc.lib
  ];

  autoPatchelfIgnoreMissingDeps = [
    "libmex.so"
    "libMatlabDataArray.so"
    "libut.so"
  ];

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall
    mkdir -p $out/lib
    cp mosek/11.0/tools/platform/linux64x86/bin/libmosek64.so.11.0 $out/lib/
    cp mosek/11.0/tools/platform/linux64x86/bin/libtbb.so.12.12 $out/lib/
    ln -s $out/lib/libmosek64.so.11.0 $out/lib/libmosek64.so
    ln -s $out/lib/libtbb.so.12.12 $out/lib/libtbb.so
    ln -s $out/lib/libtbb.so.12.12 $out/lib/libtbb.so.12
    install -D -m755 mosek/11.0/tools/platform/linux64x86/bin/mosek $out/bin/mosek
    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://www.mosek.com";
    description = "Mathematical optimization software";
    platforms = platforms.linux;
  };
}
