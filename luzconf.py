from luz import Control, Meta, Module, Script, Submodule

# define meta options
meta = Meta(
    release=True,
    archs=["arm64", "arm64e"],
    cc="/usr/bin/gcc",
    swift="/usr/bin/swift",
    compression="zstd",
    platform="iphoneos",
    sdk="~/.luz/sdks/iPhoneOS14.5.sdk",
    rootless=True,
    min_vers="15.0",
)

# define control options
control = Control(
    maintainer="Christopher Anderson",
    architecture="iphoneos-arm64",
    id="com.christopher.olympus",
    name="Olympus",
    author="Christopher Anderson",
    description="Quick lockscreen app launcher",
    section="Tweaks",
    version="1.0.0-beta2",
    depends="firmware (>= 15.0), mobilesubstrate",  # add rootless preference loader ??
)

# define modules
modules = [
    Module(
        filter={"bundles": ["com.apple.SpringBoard"]},
        files=["*.x"],
        name="Olympus",
        private_frameworks=["SpringBoardFoundation", "MobileCoreServices"],
        framework_dirs=["~/.luz/vendor/lib"],
        frameworks=["UIKit", "Cephei"],
        include_dirs=["~/.luz/vendor/lib/Cephei.framework/Headers"],
    )
]

# define submodules
submodules = [Submodule(path="./olympusprefs")]
