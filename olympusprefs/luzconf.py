from luz import Control, Meta, Module, Script, Submodule

# # define meta options
# meta = Meta(
#     release=True,
#     archs=["arm64", "arm64e"],
#     cc="/usr/bin/gcc",
#     swift="/usr/bin/swift",
#     compression="zstd",
#     platform="iphoneos",
#     sdk="~/.luz/sdks/iPhoneOS14.5.sdk",
#     rootless=True,
#     min_vers="15.0",
# )

# # define control options
# control = Control(
#     maintainer="Christopher Anderson",
#     architecture="iphoneos-arm64",
#     name="olympusprefs",
#     id="OLY",
#     version="1.0.0-beta2",
# )

# define modules
modules = [
    Module(
        files=[
            "*.m",
        ],
        name="olympusprefs",
        type="preferences",
        private_frameworks=["SpringBoardFoundation", "MobileCoreServices"],
        framework_dirs=["~/.luz/vendor/lib"],
        frameworks=["Cephei", "UIKit"],
        resources_dir="/Users/christopher/Documents/Code/theos-tweaks/Olympus/olympusprefs/Resources",
    )
]
