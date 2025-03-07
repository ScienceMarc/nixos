{ unstablePkgs, super }:{
  mesa = super.mesa.overrideAttrs (oldAttrs: {
    version = "25.0.1";
    src = super.fetchurl {
      url = "https://mesa.freedesktop.org/archive/mesa-25.0.1.tar.xz";
      sha256 = "SetVulrMyukd61Zlc6anMUSg85AUvhmC14whxbawuz8=";
    };
    patches = []; # Disable patches


    nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [
      super.llvmPackages_latest.llvm.dev # Ensure llvm-config is present
      super.llvmPackages_latest.llvm
      super.llvmPackages_latest.libllvm
      super.llvmPackages_latest.clang
      super.llvmPackages_latest.lld
      unstablePkgs.llvmPackages_latest.spirv-llvm-translator # Ensures correct SPIR-V support
      super.meson
      super.pkg-config
      super.cmake
    ];

    buildInputs = (oldAttrs.buildInputs or []) ++ [
      super.llvmPackages_latest.llvm.dev # Ensure llvm-config is present
      super.llvmPackages_latest.llvm
      super.llvmPackages_latest.libllvm
      super.llvmPackages_latest.clang
      unstablePkgs.llvmPackages_latest.spirv-llvm-translator # Ensures correct SPIR-V support
    ];

    # Ensure LLVM_CONFIG is set before using it
    preConfigure = ''
      LLVM_CONFIG=${super.llvmPackages_latest.llvm.dev}/bin/llvm-config
      export LLVM_CONFIG

      export CC=${super.llvmPackages_latest.clang}/bin/clang
      export CXX=${super.llvmPackages_latest.clang}/bin/clang++
      export LDFLAGS="-L$($LLVM_CONFIG --libdir)"
      export CFLAGS="-I$($LLVM_CONFIG --includedir)"
      export CXXFLAGS="-I$($LLVM_CONFIG --includedir)"
      export PKG_CONFIG_PATH="$($LLVM_CONFIG --libdir)/pkgconfig:$PKG_CONFIG_PATH"

      # Set LLVM_DIR only if llvm-config provides a valid cmakedir
      LLVM_CMAKE_DIR="$($LLVM_CONFIG --cmakedir 2>/dev/null)"
      if [ -d "$LLVM_CMAKE_DIR" ]; then
        export LLVM_DIR="$LLVM_CMAKE_DIR"
        export CMAKE_PREFIX_PATH="$LLVM_DIR:$CMAKE_PREFIX_PATH"
      fi

      export NIX_LDFLAGS+=" -L$($LLVM_CONFIG --libdir)"

    # Ensure SPIRV-LLVM-Translator is found
      SPIRV_LIB_PATH=${super.llvmPackages_latest.spirv-llvm-translator}/lib
      export LDFLAGS="$LDFLAGS -L$SPIRV_LIB_PATH"
      export PKG_CONFIG_PATH="$SPIRV_LIB_PATH/pkgconfig:$PKG_CONFIG_PATH"
    '';

    configurePhase = ''
      runHook preConfigure

      meson setup build \
        -Dgallium-drivers="radeonsi,iris,nouveau,swrast" \
        -Dvulkan-drivers="intel,amd" \
        -Dglx=dri \
        -Dllvm=true \
        -Dosmesa=true \
        -Dgbm=true \
        -Degl=true \
        -Dgles1=false \
        -Dgles2=true \
        -Dopengl=true \
        -Dshared-glapi=true \
        -Dshared-llvm=true \
        -Dplatforms=x11,wayland \
        -Dbuild-tests=false \
        -Dcpp_rtti=true

      runHook postConfigure
    '';



  });
}