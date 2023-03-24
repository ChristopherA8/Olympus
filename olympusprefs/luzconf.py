from luz import Module

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
        frameworks=["UIKit"], # AltList rootless or make our own
        resources_dir="/Users/christopher/Documents/Code/theos-tweaks/Olympus/olympusprefs/Resources",
    )
]
