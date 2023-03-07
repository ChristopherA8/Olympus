TARGET := iphone:clang:14.5
INSTALL_TARGET_PROCESSES = SpringBoard
export THEOS_DEVICE_IP=192.168.50.231

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Olympus

Olympus_FILES = Tweak.xm
Olympus_PRIVATE_FRAMEWORKS = SpringBoardFoundation
Olympus_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
